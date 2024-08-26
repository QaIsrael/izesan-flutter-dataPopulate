import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:izesan/model/lessons.dart';
import 'package:izesan/services/file_handler.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import '../../model/bodypart_box_model.dart';
import '../../model/lesson_box_model.dart';
import '../../services/error_state.dart';
import '../../utils/colors.dart';
import '../../utils/helper_widgets.dart';
import '../../utils/local_store.dart';
import '../../utils/route_name.dart';
import '../../utils/toast.dart';
import '../../viewmodels/leaning_view_model.dart';
import '../../viewmodels/settings_model.dart';
import '../../widgets/app_large_text.dart';

class LessonsScreen extends StatefulWidget {
  final Map<String, dynamic> options;

  const LessonsScreen({super.key, required this.options});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen>
    with TickerProviderStateMixin {
  final ErrorState _errorStateCtrl = locator<ErrorState>();
  late StreamSubscription<ErrorStatus> errorStateSub;
  final FileHandler _fileHandler = FileHandler();
  final ValueNotifier<List<LessonBoxModel>> izsLessonData =
      ValueNotifier<List<LessonBoxModel>>([]);
  late Box<LessonBoxModel> lessonBox;
  List<LessonBoxModel> lessons = <LessonBoxModel>[];

  // ValueNotifier<List<Lessons>> lessonsNotifier = ValueNotifier(<Lessons>[]);

  @override
  void initState() {
    super.initState();
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
    Future.microtask(() {
      initializeLessonData();
    });
  }

  @override
  void dispose() {
    errorStateSub.cancel();
    super.dispose();
  }

  Future<dynamic> initializeLessonData() async {
    lessonBox = await Hive.openBox<LessonBoxModel>('lessons_box');
    List<LessonBoxModel> existingData = lessonBox.values.toList();

    if (existingData.isEmpty) {
      return await getIzesanLesson();
    }
    if (existingData.isNotEmpty) {
        izsLessonData.value = existingData;
      setState(() {
        lessons = existingData;
      });
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

    if (mounted) {
      izsLessonData.value = lessonBox.values.toList();
      setState(() {
        lessons = lessonBox.values.toList();
      });
    }
  }

  void _showErrorMessage(ErrorStatus event) {
    if (mounted) {
      var error = Provider.of<SettingsModel>(context, listen: false);
      if (error.errorMessage != null) {
        CustomToastQueue.showCustomToast(
          context,
          error.errorMessage.toString(),
          Icons.close,
          AppColors.redTint,
          const Duration(seconds: 5),
          'error',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 50,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.west,
                  size: 24,
                  color: AppColors.captionColor,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Semantics(
        label: 'Student Lessons',
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const AppLargeText(text: 'Lessons'),
              addVerticalSpace(24),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount;
                    if (constraints.maxWidth >= 1200) {
                      crossAxisCount = 4;
                    } else if (constraints.maxWidth >= 800) {
                      crossAxisCount = 4;
                    } else {
                      crossAxisCount = 2;
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.15),
                      child: ValueListenableBuilder(
                        valueListenable: izsLessonData,
                        builder: (context, value, child) {
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              mainAxisExtent: 350.0,
                            ),
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              final lesson = lessons[index];
                              return Center(
                                child: InkWell(
                                  hoverColor: Colors.transparent,
                                  onTap: () {
                                    _handleGotoGames(lesson.id);
                                  },
                                  child: SizedBox(
                                    width: 230,
                                    height: 350,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: SizedBox(
                                              height: 130,
                                              width: 130,
                                              child: Image.file(
                                                File(lesson.mediaUrl),
                                                height: 130,
                                                width: 130,
                                              ),
                                            ),
                                          ),
                                          addVerticalSpace(8),
                                          Text(
                                            lesson.title,
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleGotoGames(typeId) async {
    var name = widget.options['name'];
    var langId = widget.options['langId'];
    await Navigator.of(context).pushNamed(RouteName.games, arguments: {
      'langID': langId,
      'typeID': typeId.toString(),
      'name': name
    });
  }
}
