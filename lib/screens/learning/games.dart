import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:izesan/model/bodypart_box_model.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/viewmodels/games_view_model.dart';
import 'package:izesan/widgets/app_large_text.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../locator.dart';
import '../../model/body_part_model.dart';
import '../../services/error_state.dart';
import '../../services/file_handler.dart';
import '../../utils/colors.dart';
import '../../utils/local_store.dart';
import '../../utils/toast.dart';
import '../../widgets/app_text.dart';
import '../../widgets/card.dart';
import '../../widgets/izs_flat_button.dart';
import '../../widgets/line.dart';

class GamesScreens extends StatefulWidget {
  final Map<String, dynamic> options;

  const GamesScreens({super.key, required this.options});

  @override
  _GamesScreensState createState() => _GamesScreensState();
}

class _GamesScreensState extends State<GamesScreens> {
  final ErrorState _errorStateCtrl = locator<ErrorState>();
  late StreamSubscription<ErrorStatus> errorStateSub;
  final FileHandler _fileHandler = FileHandler();

  final ValueNotifier<List<BodyPartModel>> izsBodyPartGameData =
      ValueNotifier<List<BodyPartModel>>([]);
  Future<List<dynamic>>? partOfBodyData;
  late Box<BodyPartModel> bodyPartBox;
  List<BodyPartModel> bodyParts = <BodyPartModel>[];
  List<BodyPartModel> filteredBodyParts = <BodyPartModel>[];
  OptionBP? selectedOption;
  bool bodyPartVisible = false;
  late double _progress = 0.0;
  late double _progressCount = 0.0;
  final player = AudioPlayer();
  int currentIndex = 0;
  Color btnColor = AppColors.warningCaption;

  @override
  void initState() {
    super.initState();
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
    Future.microtask(() {
      initializeBodyData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _progress = 0.0;
    _progressCount = 0.0;
    errorStateSub.cancel();
  }

  void _showErrorMessage(ErrorStatus event) {
    if (mounted) {
      var error = Provider.of<GamesViewModel>(context, listen: false);
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
    final Size screenSize = MediaQuery.of(context).size;
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
            // Set the left margin here
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: screenSize.width * 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppText(text: '${_progressCount.toInt()}%', size: 24),
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
                  IconButton(
                    icon:
                        const Icon(Icons.favorite_sharp, color: Colors.orange),
                    onPressed: () {
                      // Navigate to next page
                    },
                  ),
                ],
              ),
            ),
            addVerticalSpace(24),
        ValueListenableBuilder(
          valueListenable: izsBodyPartGameData,
          builder: (BuildContext context, List<BodyPartModel> value, child) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              width: screenSize.width * 0.9,
              height: screenSize.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  filteredBodyParts.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppLargeText(
                          text: 'Question No. ${currentIndex + 1}',
                          size: 20,
                        ),
                        addVerticalSpace(24),
                        AppLargeText(
                          text: filteredBodyParts[currentIndex].title,
                          size: 20,
                        ),
                        addVerticalSpace(24),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: filteredBodyParts[currentIndex]
                                .options
                                .map((option) {
                              final isSelected = option == selectedOption;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedOption = option;
                                  });
                                    playSelectedAudio(option.mediaUrl);
                                },
                                child: ColoredCard(
                                  cardColor: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: 10,
                                  borderColor: isSelected ? AppColors.favouriteCard : Colors.transparent,
                                  border: isSelected ? 5 : 0,
                                  margin: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              maxWidth: 100,
                                              maxHeight: 100,
                                              minHeight: 100,
                                              minWidth: 100
                                            ),
                                            child:  Image.asset(option.imageUrl)
                                          ),
                                        ),
                                        addVerticalSpace(12),
                                        const Line(
                                          width: 130,
                                          height: 2,
                                        ),
                                        addVerticalSpace(8),
                                        AppText(text: option.title),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        addVerticalSpace(40),
                        IzsFlatButton(
                          width: 180,
                          height: 40,
                          isResponsive: false,
                          color: btnColor,
                          text: 'Check Answer',
                          textSize: 14,
                          textColor: Colors.white,
                          borderRadius: 8,
                          onPressed: () {
                            if (selectedOption != null) {
                              bool isCorrect = selectedOption!.isCorrect == 1;
                              if (isCorrect) {
                                if (currentIndex < filteredBodyParts.length - 1) {
                                  setState(() {
                                    btnColor = AppColors.gloGreen;
                                  });
                                  _showNextItem();
                                }
                                playSound(true);
                              } else {
                                playSound(false);
                              }
                            }
                          },
                          borderColor: Theme.of(context).cardColor,
                          borderWidth: 0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        )
          ],
        ),
      ),
    );
  }

  Future<void> initializeBodyData() async {
    // bodyPartBox = await Hive.openBox<BodyPartBoxModel>('body_part_data');
    // List<BodyPartBoxModel> existingData = bodyPartBox.values.toList();
    // final selectedLanguage = widget.options['name'];

    // if (existingData.isNotEmpty) {
    //   setState(() {
    //     // bodyParts = existingData;
    //     izsBodyPartGameData.value = existingData;
    //     filteredBodyParts = bodyParts
    //         . where((part) => part.language.name == selectedLanguage)
    //         .toList();
    //   });
    // }

    // Check for updates in the background
    await getIzesanGamesType();
  }

  Future getIzesanGamesType() async {
    var landId = widget.options['langID'];
    var topicId = widget.options['typeID'];
    var name = widget.options['name'];

    List<BodyPartModel> res;

    try {
      res = await context.read<GamesViewModel>()
          .getGamesByType(landId, topicId, name);
      if (res.isNotEmpty) {
        setState(() {
          // bodyParts = existingData;
          izsBodyPartGameData.value = res;
          filteredBodyParts = res;
          // . where((part) => part.language.name == name)
          // .toList();
        });
        // await _insertLessonData(res, name);
        }
    } catch (e) {
      res = [];
    }
  }

  // Future<void> _insertLessonData(
  //     List<BodyPartModel> games, String langName) async {
  //   List<BodyPartBoxModel> newBodyParts = [];
  //   bodyPartBox = await Hive.openBox<BodyPartBoxModel>('body_part_data');
  //
  //   for (var game in games) {
  //     int? existingKey = _findExistingKey(game.id);
  //
  //     if (game.language.name != langName) {
  //       game.language.name = langName;
  //     }
  //
  //     await _downloadMediaFiles(game.options);
  //
  //     List<OptionBodyPart> options = game.options.map((option) {
  //       return OptionBodyPart(
  //         id: option.id,
  //         title: option.title,
  //         hint: option.hint,
  //         mediaUrl: option.mediaUrl,
  //         mediaType: option.mediaType,
  //         imageUrl: option.imageUrl,
  //         isCorrect: option.isCorrect,
  //         localImageUrl: '',
  //         localMediaUrl: '',
  //       );
  //     }).toList();
  //
  //     // TopicBodyPart topic = _mapTopic(game.topic);
  //     LanguageBodyPart language = _mapLanguage(game.language);
  //
  //     BodyPartBoxModel bodyPartBoxModel = BodyPartBoxModel(
  //       id: game.id,
  //       title: game.title,
  //       instruction: game.instruction,
  //       nextQuestionId: game.nextQuestionId,
  //       answeredType: game.answeredType,
  //       mediaUrl: game.mediaUrl,
  //       imageUrl: game.imageUrl,
  //       mediaType: game.mediaType,
  //       // topic: topic,
  //       options: options,
  //       language: language,
  //     );
  //
  //     if (existingKey != null) {
  //       await bodyPartBox.put(existingKey, bodyPartBoxModel);
  //     } else {
  //       await bodyPartBox.add(bodyPartBoxModel);
  //     }
  //   }
  // }

  // int? _findExistingKey(String id) {
  //
  //   for (var key in bodyPartBox.keys) {
  //     var bodyPart = bodyPartBox.get(key);
  //     if (bodyPart != null && bodyPart.id == id) {
  //       return key;
  //     }
  //   }
  //   return null;
  // }
  //
  // Future<void> _downloadMediaFiles(List<OptionBP> options) async {
  //   for (var option in options) {
  //     final audioFile = await _fileHandler.downloadAndSaveAudio(
  //         option.mediaUrl, 'audios/${option.id}.mp3');
  //     option.localMediaUrl = audioFile;
  //
  //     final pngFile = await _fileHandler.downloadSaveGameImage(
  //         option.imageUrl, 'images/${option.id}.png');
  //     option.localImageUrl = pngFile;
  //   }
  // }
  //
  // // TopicBodyPart _mapTopic(TopicBP topic) {
  // //   return TopicBodyPart(
  // //     id: topic.id,
  // //     title: topic.title,
  // //     description: topic.description,
  // //   );
  // // }

  // LanguageBodyPart _mapLanguage(LanguageBP language) {
  //   return LanguageBodyPart(
  //     id: language.id,
  //     name: language.name,
  //   );
  // }

  Future<void> playSound(bool isCorrect) async {
    if (isCorrect) {
      await player.play(AssetSource('audio/yipee.mp3'));
    } else {
      await player.play(AssetSource('audio/error-sound.mp3'));
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          btnColor = AppColors.warningCaption;
        });
      });
      setState(() {
        btnColor = AppColors.errorColor;
      });
    }
  }

  void playSelectedAudio(path) async {
    try {
      if (path.startsWith('http')) {
        // Play sound from an online URL
        await player.play(UrlSource(path));
      } else {
        // Play sound from a local file
        await player.play(AssetSource(path));
      }
    } catch (e) {
      print("Error playing sound: $e");
    }
  }


  void _showNextItem() {
    setState(() {
      if (currentIndex < filteredBodyParts.length - 1 &&
          selectedOption!.isCorrect == 1) {
        currentIndex++;
        selectedOption = null;
      }
    });
    _incrementProgress();
  }

  void _incrementProgress() {
    Future.delayed(const Duration(seconds: 2), () {
      double value = 1 / (filteredBodyParts.length - 1);
      double count = 100 / filteredBodyParts.length;
      setState(() {
        _progress += value;
        _progressCount += count;
        if (_progress > 1.0) {
          _progress = 1.0;
        }
        btnColor = AppColors.warningCaption;
      });
    });
  }

  void _showPreviousItem() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }
}