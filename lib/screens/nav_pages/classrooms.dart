import 'dart:async';

import 'package:izesan/locator.dart';
import 'package:izesan/services/error_state.dart';
import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/constants.dart';
import 'package:izesan/utils/toast.dart';
import 'package:izesan/viewmodels/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/helper_widgets.dart';
import '../../utils/local_store.dart';
import '../../utils/route_name.dart';
import '../../widgets/app_large_text.dart';
import '../../widgets/app_text.dart';
import '../../widgets/izs_header_text.dart';

class ClassRooms extends StatefulWidget {
  const ClassRooms({super.key});

  @override
  State<ClassRooms> createState() => _ClassRoomsState();
}

class _ClassRoomsState extends State<ClassRooms> with TickerProviderStateMixin {
  final _formkey = GlobalKey<FormState>();
  final ErrorState _errorStateCtrl = locator<ErrorState>();

  late StreamSubscription<ErrorStatus> errorStateSub;

  ValueNotifier<List<LearningResourcesData>> _classesNotifier =
  ValueNotifier(<LearningResourcesData>[]);
  final List _classes = [
    {'name': 'Primary 1a', 'arm': 'Primary 2b', 'image': 'assets/images/logo.png'},
    {'name': 'Primary 2b', 'arm': 'Primary 2b', 'image': 'assets/images/logo.png'},
  ];

  @override
  void initState() {
    super.initState();
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Semantics(
          label: 'learning games Listview',
          child: ValueListenableBuilder<List<LearningResourcesData>>(
              valueListenable: _classesNotifier,
              builder: (context, gamesAssets, child) {
                if (_classesNotifier.value.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                            width: screenWidth * 0.8,
                            height: 50,
                            margin: const EdgeInsets.only(top: 24),
                            padding: const EdgeInsets.only(left: 24),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Align(
                                alignment: Alignment.centerLeft,
                                child: IzsHeaderText(text: 'Classes'))),
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
                                itemCount: _classes.length,
                                itemBuilder: (context, index) {
                                  final language = _classes[index];
                                  return Center(
                                    child: InkWell(
                                      hoverColor: Colors.transparent,
                                      borderRadius: BorderRadius.circular(cardRadius),
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed(RouteName.teacherClassRoom);
                                      },
                                      child: SizedBox(
                                        height: 200,
                                        width: 320,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(cardRadius),
                                            color: Theme.of(context).cardColor,
                                            boxShadow: [generateBoxShadow(context)],
                                            border: Border(
                                              bottom: BorderSide(color: Colors.green, width: 2.0),
                                            ),
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
      ),
    );
  }

  _showErrorMessage(event) {
    if (mounted) {
      var error = Provider.of<SettingsModel>(context, listen: false);
      if (error.errorMessage != null) {
        return CustomToastQueue.showCustomToast(
            context,
            error.errorMessage.toString(),
            Icons.close,
            AppColors.redTint,
            const Duration(seconds: 5),
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
    this.image,
  });
}
