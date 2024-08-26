import 'package:flutter/material.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/widgets/app_large_text.dart';
import 'package:izesan/widgets/card.dart';

import '../../utils/colors.dart';
import '../../widgets/app_text.dart';
import '../../widgets/izs_flat_button.dart';

class ClassTermConfigScreen extends StatefulWidget {
  const ClassTermConfigScreen({super.key});

  @override
  _ClassTermConfigScreenState createState() => _ClassTermConfigScreenState();
}

class _ClassTermConfigScreenState extends State<ClassTermConfigScreen> {
  String _selectedTerm = 'First Term';
  String _selectedClass = 'Select a class';
  String _selectedCurriculum = 'Select a curriculum';

  final List<String> terms = ['First Term', 'Second Term', 'Third Term'];
  final List<String> classes = ['Select a class', 'Class 1', 'Class 2', 'Class 3'];
  final List<String> curriculums = ['Select a curriculum', 'Curriculum 1', 'Curriculum 2', 'Curriculum 3'];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth > 800 ? 800 : screenWidth * 0.9;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: const AppText(text:'Welcome, Test!'),
        // actions: [
        //   const Icon(Icons.school),
        // ],
      ),
      body: Center(
        child: SizedBox(
          width: screenWidth * 0.8,
          height: screenHeight * 0.8,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ColoredCard(
              cardColor: Theme.of(context).cardColor,
              borderRadius: 16,
              borderColor: Colors.transparent,
              border: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AppLargeText(
                      text:'Class And Term Configuration',
                    ),
                    addVerticalSpace(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppText(text:'Term'),
                        SizedBox(
                          width: 400,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    dropdownColor: Theme.of(context).cardColor,
                                    value: _selectedTerm,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedTerm = newValue!;
                                      });
                                    },
                                    items: terms.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: AppText(text:value),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              addHorizontalSpace(24),
                              IzsFlatButton(
                                width: 120,
                                height: 40,
                                isResponsive: false,
                                color: AppColors.primaryColor,
                                text: 'Set Term',
                                textSize: 14,
                                textColor: Colors.white,
                                borderRadius: 8,
                                onPressed: () {
                                },
                                borderColor: Theme.of(context).cardColor,
                                borderWidth: 0,
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppText(text:'Class'),
                        Container(
                          width: 400,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: Theme.of(context).cardColor,

                              value: _selectedClass,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedClass = newValue!;
                                });
                              },
                              items: classes.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: AppText(text:value),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppText(text:'Curriculum'),
                        SizedBox(
                          width: 400,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    dropdownColor: Theme.of(context).cardColor,
                                    value: _selectedCurriculum,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedCurriculum = newValue!;
                                      });
                                    },
                                    items: curriculums.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: AppText(text:value),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              addHorizontalSpace(24),
                              IzsFlatButton(
                                width: 120,
                                height: 40,
                                isResponsive: false,
                                color: AppColors.primaryColor,
                                text: 'Connect Class',
                                textSize: 14,
                                textColor: Colors.white,
                                borderRadius: 8,
                                onPressed: () {
                                },
                                borderColor: Theme.of(context).cardColor,
                                borderWidth: 0,
                              ),
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
        ),
      ),
    );
  }
}
