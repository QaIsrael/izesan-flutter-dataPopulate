import 'dart:async';

import 'package:izesan/locator.dart';
import 'package:izesan/services/error_state.dart';
import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/toast.dart';
import 'package:izesan/viewmodels/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/helper_widgets.dart';
import '../../utils/local_store.dart';
import '../../utils/route_name.dart';
import '../../widgets/app_large_text.dart';
import '../../widgets/app_text.dart';

class AccentCoach extends StatefulWidget {
  const AccentCoach({super.key});

  @override
  State<AccentCoach> createState() => _AccentCoachState();
}

class _AccentCoachState extends State<AccentCoach> with TickerProviderStateMixin{
  // final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  final _formkey = GlobalKey<FormState>();
  final ErrorState _errorStateCtrl = locator<ErrorState>();

  //Listen to the error stream
  late StreamSubscription<ErrorStatus> errorStateSub;

  ValueNotifier<List<LearningResourcesData>> languagesNotifier =
  ValueNotifier(<LearningResourcesData>[]);
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

  @override
  void initState() {
    super.initState();
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Semantics(
        label: 'learning games Listview',
        child: ValueListenableBuilder<
            List<LearningResourcesData>>(
            valueListenable: languagesNotifier,
            builder: (context, gamesAssets, child) {

              // if (gamesNotifier.value.isEmpty) {
              //   return const EmptyState(
              //       subtitleText: 'No Games Available',
              //       imageLink: 'assets/images/logo.png',
              //       titleText: 'Warning');
              //   // SizedBox();
              // } else
              //
              if (languagesNotifier.value.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const AppLargeText(
                        text:'Language',
                      ),
                      const AppText(
                        text:'Choose your native language',
                      ),
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

                            return GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: languages.length,
                              itemBuilder: (context, index) {
                                final language = languages[index];
                                return InkWell(
                                  hoverColor: Colors.transparent,
                                  onTap: (){
                                    Navigator.of(context)
                                        .pushNamed(RouteName.recordingScreen);
                                  },
                                  child: Card(
                                    color: Theme.of(context).cardColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          language['image']!,
                                          width: 80,
                                          height: 80,
                                        ),
                                        addVerticalSpace(8),
                                        Text(
                                          language['name']!,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
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
    );
  }

  _showErrorMessage(event) {
    if(mounted){
      var error = Provider.of<SettingsModel>(context, listen: false);
      if (error.errorMessage != null) {
        return CustomToastQueue.showCustomToast(
            context,
            error.errorMessage.toString(),
            Icons.close,
            AppColors.redTint, const Duration(seconds: 5),
            'error'
        );
      }
    }
  }
  
}


class LearningResourcesData {
  late String? name;
  late String? image;

  LearningResourcesData({
    this.name,
    this.image
  });
}