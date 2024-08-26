import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/utils/lessons.dart';
import 'package:provider/provider.dart';
import '../../locator.dart';
import '../../model/body_part_model.dart';
import '../../model/bodypart_box_model.dart';
import '../../model/language_box_model.dart';
import '../../model/languages.dart';
import '../../model/lesson_box_model.dart';
import '../../model/lessons.dart';
import '../../model/parent_user.dart';
import '../../model/school_user.dart';
import '../../model/student_user.dart';
import '../../model/teacher_user.dart';
import '../../services/error_state.dart';
import '../../services/file_handler.dart';
import '../../services/user_manager.dart';
import '../../utils/colors.dart';
import '../../utils/local_store.dart';
import '../../utils/route_name.dart';
import '../../utils/toast.dart';
import '../../viewmodels/games_view_model.dart';
import '../../viewmodels/home_page_model.dart';
import '../../viewmodels/leaning_view_model.dart';
import '../../widgets/app_text.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/izs_flat_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final ErrorState _errorStateCtrl = locator<ErrorState>();
  late StreamSubscription<ErrorStatus> errorStateSub;
  final UserManager userManager = locator<UserManager>();

  final ValueNotifier<List<LanguageBoxModel>> izsLanguageData =
      ValueNotifier<List<LanguageBoxModel>>([]);
  List<LanguageBoxModel> languages = <LanguageBoxModel>[];
  late Box<LessonBoxModel> lessonBox;
  List<LessonBoxModel> lessons = <LessonBoxModel>[];

  Future<List<dynamic>>? partOfBodyData;
  late Box<BodyPartBoxModel> bodyPartBox;
  List<BodyPartBoxModel> bodyParts = <BodyPartBoxModel>[];

  final FileHandler _fileHandler = FileHandler();
  double _progress = 0.0;
  bool lastIndex = false;
  var currentIndex = 0;


  @override
  void initState() {
    super.initState();
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);

    Future.delayed(const Duration(milliseconds: 2000), () async {
      getUserDetailsLocalStorage();
    });
  }

  Future<void> getUserDetailsLocalStorage() async {
    final sessionManager = LocalStoreHelper();
    final sessionData = await sessionManager.getUser();

    if (!mounted) return;

    if (sessionData != null) {
      configureAppBasedOnUser(sessionData);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          RouteName.welcomePage, (Route<dynamic> route) => false);
    }
  }

  void configureAppBasedOnUser(Map<String, dynamic> sessionData) {
    String userType = sessionData['userType'];
    Map<String, dynamic> userData = sessionData['userData'];

    switch (userType) {
      case 'School':
        SchoolUser schoolUser = SchoolUser.fromJson(userData);
        // Apply school specific settings
        // userManager.setUser(schoolUser);
        Navigator.of(context).pushReplacementNamed(RouteName.dashboard);
        break;
      case 'Teacher':
        TeacherUser teacherUser = TeacherUser.fromJson(userData);
        // Apply teacher specific settings
        // userManager.setUser(teacherUser);
        Navigator.of(context).pushReplacementNamed(RouteName.teachersDashboard);
        break;
      case 'Student':
        StudentUser studentUser = StudentUser.fromJson(userData);
        // Apply student specific settings
        // userManager.setUser(studentUser);
        // promises();
        // processAllLessons(lessonsData);
        Navigator.of(context).pushReplacementNamed(RouteName.studentDashboard);
        break;
      case 'Parent':
        ParentUser parentUser = ParentUser.fromJson(userData);
        // Apply parent-specific settings
        // userManager.setUser(parentUser);
        Navigator.of(context).pushReplacementNamed(RouteName.studentDashboard);
        break;
      default:
        Navigator.of(context).pushReplacementNamed(RouteName.welcomePage);
        break;
    }
  }

  _showErrorMessage(event) {
    if (mounted) {
      var error = Provider.of<HomePageModel>(context, listen: false);
      if (error.errorMessage != null) {
        return CustomToastQueue.showCustomToast(
            context,
            error.errorMessage.toString(),
            Icons.close,
            AppColors.redTint,
            const Duration(seconds: 5),
            'error');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    errorStateSub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Semantics(
          label: 'Splash screen',
          child: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset("assets/images/logo.png")),
                    addVerticalSpace(20),
                    SizedBox(
                      width: screenSize.width * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const AppText(text: 'Loading...', size: 18),
                          addVerticalSpace(16),
                          SizedBox(
                            width: screenSize.width * 0.5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: LinearProgressIndicator(
                                value: _progress,
                                color: AppColors.favouriteCard,
                                backgroundColor: AppColors.captionColor,
                                minHeight: 20,
                              ),
                            ),
                          ),
                          addVerticalSpace(20),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed(RouteName.studentDashboard);
                            },
                            child: const SizedBox(
                              height: 40,
                              width: 300,
                              child: Center(child: AppText(text:'Close')),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future promises() async {
    List futures = await Future.wait([
      // _getMeDetails(),
      getLanguagesLocalStore(),
      initializeLessonData(),
    ]);
    for (var future in futures) {
      if (future != null) {
        return future;
      }
    }
    return null;
  }

  Future<dynamic> getLanguagesLocalStore() async {
    Box<LanguageBoxModel> languageBox =
        await Hive.openBox<LanguageBoxModel>('language_box');

    List<LanguageBoxModel> data = languageBox.values.toList();

    if (data.isEmpty) {
      return getIzesanLanguages();
    }
    if (data.isNotEmpty) {
      izsLanguageData.value = data;
      return data;
    }
    return data;
  }

  Future getIzesanLanguages() async {
    try {
      List<Languages> res =
          await context.read<LearningViewModel>().getLanguages();

      if (res.isEmpty) {
        return izsLanguageData.value = <LanguageBoxModel>[];
      }
      insertLanguageData(res);
    } catch (e) {
      return [];
    }
  }

  Future insertLanguageData(data) async {
    Box<LanguageBoxModel> languageBox =
        await Hive.openBox<LanguageBoxModel>('language_box');
    languageBox = await Hive.openBox<LanguageBoxModel>(
        'language_box'); // Initialize the variable
    await languageBox.clear();
    //For searching and

    for (var language in data) {
      String imagePath = await _fileHandler.downloadSaveLanguageImages(
          language.imageUrl, '${language.name}.png');
      LanguageBoxModel languageBoxModel = LanguageBoxModel(
          id: language.id,
          name: language.name,
          imagePath: imagePath,
          status: language.status);
      await languageBox.add(languageBoxModel);
    }

    await getLanguagesLocalStore();
    // return updatedData;
  }

  Future<dynamic> initializeLessonData() async {
    lessonBox = await Hive.openBox<LessonBoxModel>('lessons_box');
    List<LessonBoxModel> existingData = lessonBox.values.toList();

    if (existingData.isEmpty) {
      return await getIzesanLesson();
    }
    if (existingData.isNotEmpty) {
      // setState(() {
      //   lessons = existingData;
      // });
      return existingData;
    }
  }

  Future<void> getIzesanLesson() async {
    List<Lessons> res;
    try {
      res = await context.read<LearningViewModel>().getLanguageLessons();
      if (res.isNotEmpty) {
        await _insertLessonData(res);
      }
    } catch (e) {
      res = [];
    }
  }

  Future<void> _insertLessonData(List<Lessons> data) async {
    for (var lesson in data) {
      // Check if the lesson already exists
      var existingLesson = lessonBox.values
          .firstWhereOrNull((element) => element.id == lesson.id);

      String imagePath = await _fileHandler.downloadSaveLessonsImages(
          lesson.mediaUrl, '${lesson.title}.png');
      LessonBoxModel lessonBoxModel = LessonBoxModel(
        id: lesson.id,
        createdAt: lesson.createdAt,
        title: lesson.title,
        questionType: lesson.questionType,
        description: lesson.description,
        content: lesson.content,
        objective: lesson.objective,
        mediaUrl: imagePath,
        week: lesson.week,
        type: lesson.type,
        answered: lesson.answered,
        mediaType: lesson.mediaType,
        questions: lesson.questions,
        questionCount: lesson.questionCount,
        percentage: lesson.percentage,
        lastQuestionAnswered: lesson.lastQuestionAnswered,
      );

      if (existingLesson != null) {
        // Update the existing lesson
        await lessonBox.put(existingLesson.key, lessonBoxModel);
      } else {
        // Add new lesson
        await lessonBox.add(lessonBoxModel);
      }
    }
  }

  Future<void> processAllLessons(data) async {
    while (data.isNotEmpty) {
      // await processLesson(data.first);
      // data.removeAt(0);
    }
  }

  ///Todo: filter through the lessons JSON. and call every lesson category
  ///and in each category we check if that data exist for that language all
  // Future<void> processLesson(Map<String, dynamic> lesson) async {
  //   String lessonId = lesson['lesson_id'].toString();
  //   List categories = lesson['categories'];
  //   List<BodyPartModel> res;
  //   var lastIdx = categories.length;
  //
  //   for (var category in categories) {
  //     String languageId = category['language_id'].toString();
  //     String languageName = category['language_name'];
  //
  //     double count = 1 / categories.length;
  //     bool isLastIndex = currentIndex == lastIdx ? true : false;
  //
  //     res = await context.read<GamesViewModel>()
  //         .getGamesByType(languageId, lessonId, languageName);
  //     if (res.isNotEmpty) {
  //       print('Processed lesson $lessonId for language $languageName');
  //       await _insertLessonGames(res, languageName);
  //     } else {
  //       res = [];
  //       print('Failed to fetch data for lesson $lessonId and language $languageName');
  //     }
  //
  //     // Increment currentIndex after processing
  //     // currentIndex += 1;
  //     setState(() {
  //       _progress += count;
  //       lastIndex = isLastIndex;
  //       currentIndex = currentIndex += 1;
  //     });
  //
  //     if (!mounted) {
  //       return;
  //     }
  //
  //   }
  // }

  Future<void> _insertLessonGames(List<BodyPartModel> games, String langName) async {
    List<BodyPartBoxModel> newBodyParts = [];
    bodyPartBox = await Hive.openBox<BodyPartBoxModel>('body_part_data');

    for (var game in games) {
      int? existingKey = _findExistingKey(game.id, langName);

      if (game.language.name != langName) {
        game.language.name = langName;
      }

      if (existingKey == null) {
        // Download media files and update options
        await _downloadMediaFiles(game.options);
      }

      // Map options after downloading media files
      List<OptionBodyPart> options = game.options.map((option) {
        return OptionBodyPart(
          id: option.id,
          title: option.title,
          hint: option.hint,
          mediaUrl: option.mediaUrl,
          mediaType: option.mediaType,
          imageUrl: option.imageUrl,
          isCorrect: option.isCorrect,
          localImageUrl: option.localImageUrl ?? '',
          localMediaUrl: option.localMediaUrl ?? '',
        );
      }).toList();

      // TopicBodyPart topic = _mapTopic(game.topic);
      LanguageBodyPart language = _mapLanguage(game.language);

      BodyPartBoxModel bodyPartBoxModel = BodyPartBoxModel(
        id: game.id,
        title: game.title,
        instruction: game.instruction,
        nextQuestionId: game.nextQuestionId,
        answeredType: game.answeredType,
        mediaUrl: game.mediaUrl,
        imageUrl: game.imageUrl,
        mediaType: game.mediaType,
        // topic: topic,
        options: options,
        language: language,
      );

      if (existingKey != null) {
        await bodyPartBox.put(existingKey, bodyPartBoxModel);
      } else {
        await bodyPartBox.add(bodyPartBoxModel);
      }

      if (lastIndex && mounted) {
        Navigator.of(context).pushReplacementNamed(RouteName.studentDashboard);
      }
    }
  }

  Future<void> _downloadMediaFiles(List<OptionBP> options) async {
    for (var option in options) {
      final audioFile = await _fileHandler.downloadAndSaveAudio(
          option.mediaUrl, 'audios/${option.id}.mp3');
      option.localMediaUrl = audioFile;

      final pngFile = await _fileHandler.downloadSaveGameImage(
          option.imageUrl, 'images/${option.id}.png');
      option.localImageUrl = pngFile;
    }
  }

  int? _findExistingKey(String id, String name) {
    for (var key in bodyPartBox.keys) {
      var bodyPart = bodyPartBox.get(key);
      if (bodyPart != null && bodyPart.id == id
          && bodyPart.language.name == name) {
        return key;
      }
    }
    return null;
  }

  // TopicBodyPart _mapTopic(TopicBP topic) {
  //   return TopicBodyPart(
  //     id: topic.id,
  //     title: topic.title,
  //     description: topic.description,
  //   );
  // }

  LanguageBodyPart _mapLanguage(LanguageBP language) {
    return LanguageBodyPart(
      id: language.id,
      name: language.name,
    );
  }
}
