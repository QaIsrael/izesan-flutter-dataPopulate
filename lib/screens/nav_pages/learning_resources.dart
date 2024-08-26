import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:chewie/chewie.dart';
import 'package:izesan/model/video_lessons.dart';
import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/viewmodels/leaning_view_model.dart';
import 'package:izesan/widgets/app_large_text.dart';
import 'package:izesan/widgets/app_text.dart';
import 'package:izesan/widgets/izs_header_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../locator.dart';
import '../../model/language_box_model.dart';
import '../../model/languages.dart';
import '../../model/video_lessons_box_model.dart';
import '../../services/error_state.dart';
import '../../services/file_handler.dart';
import '../../services/isolate_handler.dart';
import '../../utils/constants.dart';
import '../../utils/download_video_isolate.dart';
import '../../utils/local_store.dart';
import '../../utils/route_name.dart';
import '../../utils/toast.dart';
import '../../widgets/control_section.dart';
import '../../widgets/video_section.dart';

class LearningResources extends StatefulWidget {
  const LearningResources({Key? key}) : super(key: key);

  @override
  _LearningResourcesState createState() => _LearningResourcesState();
}

class _LearningResourcesState extends State<LearningResources>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final FileHandler _fileHandler = FileHandler();

  // final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  final TextEditingController searchController = TextEditingController();
  final ErrorState _errorStateCtrl = locator<ErrorState>();
  late StreamSubscription<ErrorStatus> errorStateSub;
  late TabController _tabController;

  bool loader = false;
  bool isResumed = false;

  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  String currentVideoTitle = "Bee Video";
  String currentCategory = "Category 1";

  final List<String> _categories = [
    'Category 1',
    'Category 2',
    'Category 3',
  ];

  final ValueNotifier<List<LanguageBoxModel>> izsLanguageData =
  ValueNotifier<List<LanguageBoxModel>>([]);
  Future<List<LanguageBoxModel>>? languageData;
  late Box<LanguageBoxModel> languageBox;
  List<LanguageBoxModel> languages = <LanguageBoxModel>[];

  // late Future<List<Languages>> _futureLanguages = Future(() => []);
  final ValueNotifier<List<VideoLessonsBoxModelHive>> izsVideoData =
  ValueNotifier<List<VideoLessonsBoxModelHive>>([]);
  List<VideoLessonsBoxModelHive> videos = <VideoLessonsBoxModelHive>[];
  Future<List<VideoLessonsBoxModelHive>>? _lessonVideos;
  late Box<VideoLessonsBoxModelHive> videoLessonBox;

  // late Future<List<VideoLessons>> _lessonVideos = Future(() => []);
  //Listen to the error stream

  @override
  void initState() {
    super.initState();
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);

    if (!mounted) return;
    languageData = Future.delayed(Duration.zero, () {
      return getLanguagesLocalStore().then((value) {
        getIzesanLanguages();
        return value;
      });
    });

    // _lessonVideos = Future.delayed(Duration.zero, () {
    //   return getVideosLocalStore().then((value) {
    //     // getIzesanVideos();
    //     return value;
    //   });
    // });

    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
    // searchController.addListener(_searchControlListener);
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && isResumed) {
      setState(() {
        // getFacility();
      });
    }
    isResumed = state == AppLifecycleState.resumed;
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    errorStateSub.cancel();
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
  }

  _showErrorMessage(event) {
    if (mounted) {
      var error = Provider.of<LearningViewModel>(context, listen: false);
      if (error.errorMessage != null) {
        CustomToastQueue.showCustomToast(
            context,
            error.errorMessage.toString(),
            Icons.close,
            AppColors.redTint,
            const Duration(seconds: toastDuration),
            'error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pushNamed(RouteName.dashboard);
            return false;
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Semantics(
              label: 'Utility screen',
              child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Column(
                  children: [
                    Container(
                      padding:
                      const EdgeInsets.only(top: 14, left: 24, right: 24),
                      child: Row(children: [
                        Semantics(
                          label: 'Learning header text',
                          child: const IzsHeaderText(
                            text: "My Learning",
                          ),
                        ),
                      ]),
                    ),
                    addVerticalSpace(24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        height: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Semantics(
                              label: 'TabBar, Games, Video tab bar',
                              child: TabBar(
                                dividerHeight: 40.0,
                                dividerColor: Colors.transparent,
                                labelPadding:
                                const EdgeInsets.only(left: 20, right: 20),
                                controller: _tabController,
                                labelColor: AppColors.primaryColor,
                                unselectedLabelColor: AppColors.captionColor,
                                isScrollable: true,
                                indicatorSize: TabBarIndicatorSize.tab,
                                tabAlignment: TabAlignment.start,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Theme.of(context).cardColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4.0,
                                      blurStyle: BlurStyle.normal,
                                      spreadRadius: 0.0,
                                      offset: const Offset(0.1,
                                          0.2), // shadow direction: bottom right
                                    )
                                  ],
                                ),
                                tabs: const [
                                  Tab(text: 'Games'),
                                  Tab(text: 'Videos'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: TabBarView(
                          controller: _tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const AppLargeText(
                                    text: 'Choose your native language',
                                  ),
                                  addVerticalSpace(24),
                                  FutureBuilder<List<LanguageBoxModel>>(
                                    future: languageData,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: AppText(
                                                text:
                                                'Error: ${snapshot.error}'));
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return const Center(
                                            child: AppText(
                                                text: 'No data available'));
                                      } else {
                                        final languages = snapshot.data!;
                                        return Expanded(
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              int crossAxisCount;
                                              if (constraints.maxWidth >=
                                                  1200) {
                                                crossAxisCount = 4;
                                              } else if (constraints.maxWidth >=
                                                  800) {
                                                crossAxisCount = 4;
                                              } else {
                                                crossAxisCount = 2;
                                              }
                                              return GridView.builder(
                                                gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount:
                                                  crossAxisCount,
                                                  crossAxisSpacing: 16,
                                                  mainAxisSpacing: 16,
                                                ),
                                                itemCount: languages.length,
                                                itemBuilder: (context, index) {
                                                  final language =
                                                  languages[index];
                                                  return InkWell(
                                                    hoverColor:
                                                    Colors.transparent,
                                                    onTap: () {
                                                      gotoLessonsScreen(language.name, language.id);
                                                    },
                                                    child: Card(
                                                      color: Theme.of(context)
                                                          .cardColor,
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8.0),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          Center(
                                                            child: SizedBox(
                                                                height: 130,
                                                                width: 130,
                                                                child: Image.file(
                                                                    height: 130,
                                                                    width: 130,
                                                                    File(language
                                                                        .imagePath))),
                                                          ),
                                                          addVerticalSpace(8),
                                                          AppLargeText(
                                                            text: language.name,
                                                            size: 20,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            FutureBuilder<List<VideoLessonsBoxModelHive>>(
                              future: _lessonVideos,
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                      child: Text('No data available'));
                                } else {
                                  List<Map<String, dynamic>> videoList =
                                  snapshot.data!.map((video) {
                                    List<String> mediaUrls = video.topics
                                        .map((topic) => topic.mediaUrl)
                                        .toList();
                                    return {
                                      'title': video.week,
                                      'mediaUrls': mediaUrls,
                                    };
                                  }).toList();
                                  return Flexible(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: double.maxFinite,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              AppText(text: currentVideoTitle),
                                              addVerticalSpace(16),
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10),
                                                  ),
                                                  child:
                                                  DropdownButtonHideUnderline(
                                                    child:
                                                    DropdownButton<String>(
                                                      dropdownColor:
                                                      Theme.of(context)
                                                          .cardColor,
                                                      value: currentCategory,
                                                      items: _categories.map(
                                                              (String category) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: category,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    8.0),
                                                                child:
                                                                Text(category),
                                                              ),
                                                            );
                                                          }).toList(),
                                                      onChanged: (newCategory) {
                                                        setState(() {
                                                          currentCategory =
                                                          newCategory!;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        addVerticalSpace(24),
                                        Expanded(
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 2,
                                                child: AspectRatio(
                                                  aspectRatio:
                                                  _videoPlayerController
                                                      ?.value
                                                      .aspectRatio ??
                                                      16 / 9,
                                                  child: VideoSection(
                                                    chewieController:
                                                    _chewieController,
                                                    videoPlayerController:
                                                    _videoPlayerController,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 24),
                                              Expanded(
                                                flex: 1,
                                                child: ControlSection(
                                                  currentCategory:
                                                  currentCategory,
                                                  videos: videoList,
                                                  onVideoTap: (video) {
                                                    setState(() {
                                                      currentVideoTitle =
                                                      video['title']!;
                                                      _initializePlayer(
                                                          video['mediaUrls']
                                                          [0]);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _initializePlayer(String url) {
    // Dispose of previous controllers
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    // Set controllers to null to avoid using disposed controllers
    setState(() {
      _videoPlayerController = null;
      _chewieController = null;
    });
    // Initialize new controllers
    _videoPlayerController = VideoPlayerController.file(File(url))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController!,
              aspectRatio: _videoPlayerController!.value.aspectRatio,
              autoPlay: false,
              looping: false,
            );
            // _videoPlayerController!.play();
          });
        }
      });
  }

  Future getIzesanLanguages() async {
    try {
      List<Languages> res =
      await context.read<LearningViewModel>().getLanguages();

      if (res.isEmpty) {
        return izsLanguageData.value = <LanguageBoxModel>[];
      }
      insertLanguageData(res);
    } catch(e) {
      return [];
    }
  }

  Future insertLanguageData(data) async {
    languageBox = await Hive.openBox<LanguageBoxModel>(
        'language_box'); // Initialize the variable
    await languageBox.clear();
    //For searching and

    for (var language in data) {
      String imagePath = await _fileHandler.downloadAndSaveVideo(
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

  Future<dynamic> getLanguagesLocalStore() async {
    Box<LanguageBoxModel> languageBox =
    await Hive.openBox<LanguageBoxModel>('language_box');

    List<LanguageBoxModel> data = languageBox.values.toList();

    if (languageBox.values.isEmpty) {
      return getIzesanLanguages();
    }
    if (languageBox.values.toList().isNotEmpty) {
      izsLanguageData.value = data;

      setState(() {
        languages = data;
        // orderData = data;
      });
      return data;
    }
    return data;
  }

  ///Todo:Use a package like flutter_secure_storage to store encryption keys securely.
  /// Use a package like encrypt to handle file encryption and decryption.

  void gotoLessonsScreen(String name, int id) {
    Navigator.of(context).pushNamed(RouteName.lessonsScreen,
        arguments: {'name': name, 'langId': id.toString()});
  }

  Future<dynamic> getVideosLocalStore() async {
    Box<VideoLessonsBoxModelHive> videoBox =
    await Hive.openBox<VideoLessonsBoxModelHive>('lessons_video_box');

    List<VideoLessonsBoxModelHive> data = videoBox.values.toList();

    if (videoBox.values.isEmpty) {
      return getIzesanVideos();
    }
    if (videoBox.values.toList().isNotEmpty) {
      izsVideoData.value = data;

      setState(() {
        videos = data;
      });
      return data;
    }
    return data;
  }

  Future getIzesanVideos() async {
    try {
      List<VideoLessons> res =
      await context.read<LearningViewModel>().getVideos();

      if (res.isEmpty) {
        return izsVideoData.value = <VideoLessonsBoxModelHive>[];
      }
      return insertVideoData(res);
    } catch(e) {
      return [];
    }
  }

  Future<String> _downloadAndSaveVideoIsolate(
      String url, String fileName) async {
    final ReceivePort receivePort = ReceivePort();
    final Directory directory = await getApplicationDocumentsDirectory();

    await Isolate.spawn(
      IsolateHandler.downloadAndSaveVideo,
      {
        'url': url,
        'fileName': fileName,
        'sendPort': receivePort.sendPort,
        'directoryPath': directory.path,
      },
    );

    final message = await receivePort.first;
    if (message == 'error') {
      throw Exception('Failed to download video');
    }

    return message as String; // Ensure this is of type String
  }

  Future insertVideoData(List<VideoLessons> res) async {
    videoLessonBox =
    await Hive.openBox<VideoLessonsBoxModelHive>('lessons_video_box');
    await videoLessonBox.clear();

    try {
      List<VideoLessons> videoResponse = res;

      // Extract and save to Hive
      List<VideoLessonsBoxModelHive> videoLessonsBoxModels =
      await Future.wait(videoResponse.map((videoJson) async {
        List<TopicsHive> topics =
        await Future.wait(videoJson.topics.map((topicJson) async {
          List<QuestionsHive> questions =
          (topicJson.questions).map((questionJson) {
            List<QuestionOptionHive> options =
            (questionJson.options).map((optionJson) {
              return QuestionOptionHive(
                id: optionJson.id,
                title: optionJson.title,
                hint: optionJson.hint,
                mediaUrl: optionJson.mediaUrl,
                mediaType: optionJson.mediaType,
                imageUrl: optionJson.imageUrl,
                isCorrect: optionJson.isCorrect,
              );
            }).toList();

            return QuestionsHive(
              id: questionJson.id,
              title: questionJson.title,
              instruction: questionJson.instruction,
              nextQuestionId: questionJson.nextQuestionId,
              answeredType: questionJson.answeredType,
              mediaUrl: questionJson.mediaUrl,
              imageUrl: questionJson.imageUrl,
              mediaType: questionJson.mediaType,
              options: options,
              optionsScrambled: questionJson.optionsScrambled,
            );
          }).toList();

          // Use isolate to download the video and get the local path
          String localMediaUrl = await _downloadAndSaveVideoIsolate(
              topicJson.mediaUrl, '${topicJson.title}.mp4');

          return TopicsHive(
            id: topicJson.id,
            title: topicJson.title,
            description: topicJson.description,
            imageUrl: topicJson.imageUrl,
            createdAt: topicJson.createdAt,
            updatedAt: topicJson.updatedAt,
            sectionId: topicJson.sectionId,
            mediaType: topicJson.mediaType,
            mediaUrl: localMediaUrl,
            // Save the local path
            type: topicJson.type,
            objective: topicJson.objective,
            content: topicJson.content,
            questionType: topicJson.questionType,
            schoolClassId: topicJson.schoolClassId,
            week: topicJson.week,
            answered: topicJson.answered,
            questions: questions,
            questionCount: topicJson.questionCount,
            percentage: topicJson.percentage,
            lastQuestionAnswered: topicJson.lastQuestionAnswered,
          );
        }).toList());

        return VideoLessonsBoxModelHive(
          week: videoJson.week,
          topics: topics,
        );
      }).toList());

      await videoLessonBox.addAll(videoLessonsBoxModels);

      return videoLessonsBoxModels;
    } catch (e) {
      rethrow;
    }
  }
}