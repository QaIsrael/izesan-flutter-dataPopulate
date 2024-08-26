import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/widgets/app_large_text.dart';
import 'package:izesan/widgets/app_text.dart';
import 'package:izesan/widgets/izs_header_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:video_player/video_player.dart';

import '../../locator.dart';
import '../../services/error_state.dart';
import '../../utils/local_store.dart';
import '../../utils/route_name.dart';
import '../../widgets/control_section.dart';
import '../../widgets/video_section.dart';

class StudentClassRoom extends StatefulWidget {
  const StudentClassRoom({Key? key}) : super(key: key);

  @override
  _StudentClassRoomState createState() => _StudentClassRoomState();
}

class _StudentClassRoomState extends State<StudentClassRoom>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final TextEditingController searchController = TextEditingController();
  late TabController _tabController;
  bool loader = false;
  late Games games;
  late Videos videos;
  bool isResumed = false;
  // final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  String gameTab = '';
  String videoTab = '';

  final ValueNotifier<List<LearningResourcesData>> learningResourceData =
  ValueNotifier<List<LearningResourcesData>>([]);
  late Box<LearningResourcesData> learningResourceBoxList;

  ValueNotifier<List<LearningResourcesData>> gamesNotifier =
  ValueNotifier(<LearningResourcesData>[]);
  ValueNotifier<List<LearningResourcesData>> videosNotifier =
  ValueNotifier(<LearningResourcesData>[]);

  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  final List<Map<String, String>> _videos = [
    {
      'title': 'Bee Video ',
      'url': 'https://res.cloudinary.com/ddsxasrjb/video/upload/v1715769640/jfr9ixqij1bbjuncc4r5.mp4'
    },
    {
      'title': 'Video 2',
      'url': 'https://res.cloudinary.com/ddsxasrjb/video/upload/v1713350227/ol0k0wjiremz3xlct20o.mp4'
    },
    {
      'title': 'Video 3',
      'url': 'https://res.cloudinary.com/ddsxasrjb/video/upload/v1713256826/pimxrjrh0l1q8ohffh11.mp4'
    },
  ];
  String currentVideoTitle = "Bee Video";
  String currentCategory = "Category 1";

  final List<String> _categories = [
    'Category 1',
    'Category 2',
    'Category 3',
  ];
  final List languages = [
    {'name': 'Yoruba', 'image': 'assets/images/logo.png'},
    {'name': 'Igbo', 'image': 'assets/images/logo.png'},
    {'name': 'Hausa', 'image': 'assets/images/logo.png'},
    {'name': 'Esan', 'image': 'assets/images/logo.png'},
    {'name': 'Patois', 'image': 'assets/images/logo.png'},
    {'name': 'Swahili', 'image': 'assets/images/logo.png'},
    {'name': 'isiXhosa', 'image': 'assets/images/logo.png'},
    {'name': 'isiZulu', 'image': 'assets/images/logo.png'},
    {'name': 'Yoruba', 'image': 'assets/images/logo.png'},
    {'name': 'Igbo', 'image': 'assets/images/logo.png'},
    {'name': 'Hausa', 'image': 'assets/images/logo.png'},
    {'name': 'isiZulu', 'image': 'assets/images/logo.png'},
    {'name': 'Esan', 'image': 'assets/images/logo.png'},
    {'name': 'Patois', 'image': 'assets/images/logo.png'},
    {'name': 'Swahili', 'image': 'assets/images/logo.png'},
    {'name': 'isiXhosa', 'image': 'assets/images/logo.png'},
    {'name': 'isiZulu', 'image': 'assets/images/logo.png'},
    {'name': 'Patois', 'image': 'assets/images/logo.png'},
  ];

  final ErrorState _errorStateCtrl = locator<ErrorState>();

  //Listen to the error stream
  late StreamSubscription<ErrorStatus> errorStateSub;

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
    if (!mounted) return;
    _initializePlayer(_videos[0]['url']!);

    // Future.microtask(() => getFacility().then((value) {
    //   getLearningResource();
    // }));

    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
    // searchController.addListener(_searchControlListener);
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
      // var error = Provider.of<LearningResourcesModel>(context, listen: false);
      // if (error.errorMessage != null) {
      //   CustomToastQueue.showCustomToast(
      //       context,
      //       error.errorMessage.toString(),
      //       Icons.close,
      //       AppColors.redTint,
      //       const Duration(seconds: toastDuration),
      //       'error');
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    String capitalize(s) => s![0].toUpperCase() + s!.substring(1).toLowerCase();
    return SafeArea(
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
                      padding: const EdgeInsets.only(top: 14, left: 24, right: 24),
                      child: Row(children: [
                        Semantics(
                          label: 'Learning header text',
                          child: const IzsHeaderText(
                            text: "My Classroom",
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
                                isScrollable: false,
                                indicatorSize: TabBarIndicatorSize.tab,
                                tabAlignment: TabAlignment.center,
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
                                  Tab(text: 'Classwork'),
                                  Tab(text: 'Quiz'),
                                  Tab(text: 'Video Quiz'),
                                  Tab(text: 'Video'),
                                  Tab(text: 'Attachments'),
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
                            Semantics(
                              label: 'learning games Listview',
                              child: ValueListenableBuilder<
                                  List<LearningResourcesData>>(
                                  valueListenable: gamesNotifier,
                                  builder: (context, gamesAssets, child) {

                                    // if (gamesNotifier.value.isEmpty) {
                                    //   return const EmptyState(
                                    //       subtitleText: 'No Games Available',
                                    //       imageLink: 'assets/images/logo.png',
                                    //       titleText: 'Warning');
                                    //   // SizedBox();
                                    // } else
                                    //
                                    if (gamesNotifier.value.isEmpty) {
                                      return Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            const AppLargeText(
                                              text:'Choose your native language',),
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
                                                  return AppLargeText(text: 'No Class Work');
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  }),
                            ),
                            Semantics(
                              label: 'Learning resource Quiz',
                              child: ValueListenableBuilder<
                                  List<LearningResourcesData>>(
                                  valueListenable: videosNotifier,
                                  builder: (context, phoneAssets, child) {
                                    if (videosNotifier.value.isEmpty) {
                                      return const Flexible(
                                        child: Column(
                                          children: [
                                            AppLargeText(text: 'No Quiz'),
                                          ],
                                        ),
                                      );
                                    } else if (videosNotifier.value.isEmpty) {
                                      return const AppText(text: 'Error No Videos' );
                                      // return const EmptyState(
                                      //     subtitleText: 'No Videos Available',
                                      //     imageLink:
                                      //     'assets/images/phone_assets.png',
                                      //     titleText: 'Warning');
                                    } else {
                                      return const AppText(text: 'Error Warning');
                                      // return EmptyState(
                                      //     subtitleText: 'No Network available',
                                      //     imageLink:
                                      //     'assets/images/no_network.png',
                                      //     titleText:'Warning');
                                    }
                                  }),
                            ),
                            Semantics(
                              label: 'Learning resource Quiz Videos',
                              child: ValueListenableBuilder<
                                  List<LearningResourcesData>>(
                                  valueListenable: videosNotifier,
                                  builder: (context, phoneAssets, child) {
                                    if (videosNotifier.value.isEmpty) {
                                      return const Flexible(
                                        child: Column(
                                          children: [
                                            AppLargeText(text: 'Assigned video quiz not found'),
                                          ],
                                        ),
                                      );
                                    } else if (videosNotifier.value.isEmpty) {
                                      return const AppText(text: 'Error No Videos' );
                                      // return const EmptyState(
                                      //     subtitleText: 'No Videos Available',
                                      //     imageLink:
                                      //     'assets/images/phone_assets.png',
                                      //     titleText: 'Warning');
                                    } else {
                                      return const AppText(text: 'Error Warning');
                                      // return EmptyState(
                                      //     subtitleText: 'No Network available',
                                      //     imageLink:
                                      //     'assets/images/no_network.png',
                                      //     titleText:'Warning');
                                    }
                                  }),
                            ),
                            Semantics(
                              label: 'Learning resource Videos',
                              child: ValueListenableBuilder<
                                  List<LearningResourcesData>>(
                                  valueListenable: videosNotifier,
                                  builder: (context, phoneAssets, child) {
                                    if (videosNotifier.value.isEmpty) {
                                      return const Flexible(
                                        child: Column(
                                          children: [
                                            AppLargeText(text: 'Video not assigned'),
                                          ],
                                        ),
                                      );
                                    } else if (videosNotifier.value.isEmpty) {
                                      return const AppText(text: 'Error No Videos' );
                                      // return const EmptyState(
                                      //     subtitleText: 'No Videos Available',
                                      //     imageLink:
                                      //     'assets/images/phone_assets.png',
                                      //     titleText: 'Warning');
                                    } else {
                                      return const AppText(text: 'Error Warning');
                                      // return EmptyState(
                                      //     subtitleText: 'No Network available',
                                      //     imageLink:
                                      //     'assets/images/no_network.png',
                                      //     titleText:'Warning');
                                    }
                                  }),
                            ),
                            Semantics(
                              label: 'Learning resource attachments',
                              child: ValueListenableBuilder<
                                  List<LearningResourcesData>>(
                                  valueListenable: videosNotifier,
                                  builder: (context, phoneAssets, child) {
                                    if (videosNotifier.value.isEmpty) {
                                      return const Flexible(
                                        child: Column(
                                          children: [
                                            AppLargeText(text: 'No classwork Assets'),
                                          ],
                                        ),
                                      );
                                    } else if (videosNotifier.value.isEmpty) {
                                      return const AppText(text: 'Error No Videos' );
                                      // return const EmptyState(
                                      //     subtitleText: 'No Videos Available',
                                      //     imageLink:
                                      //     'assets/images/phone_assets.png',
                                      //     titleText: 'Warning');
                                    } else {
                                      return const AppText(text: 'Error Warning');
                                      // return EmptyState(
                                      //     subtitleText: 'No Network available',
                                      //     imageLink:
                                      //     'assets/images/no_network.png',
                                      //     titleText:'Warning');
                                    }
                                  }),
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

  Future<void> _initializePlayer(String url) async {
    // _videoPlayerController = VideoPlayerController.network(url);
    try {
      var videoUrl = Uri.parse(url);
      _videoPlayerController = VideoPlayerController.networkUrl(videoUrl);
      await _videoPlayerController!.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: false,
        looping: false,
      );
      setState(() {});
    } catch (error) {
      print(error);
    }
  }

}

class Videos {}

class Games {}

class LearningResourcesData {
  late String? name;
  late String? image;

  LearningResourcesData({
    this.name,
    this.image
  });
}