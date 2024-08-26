import 'package:flutter/material.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/widgets/app_large_text.dart';
import 'package:path/path.dart';

import '../../utils/colors.dart';
import '../../widgets/app_text.dart';
import '../../widgets/izs_checkbox.dart';
import '../../widgets/izs_flat_button.dart';

class AssessmentView extends StatelessWidget {
  final List<dynamic> data;
  final double borderRadius = 8.0;

  AssessmentView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<String> keys = data.isNotEmpty ? data[0].keys.where((key) => key != 'id').toList() : [];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: _buildRow(context),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.8,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppLargeText(text: 'Classwork File'),
                  addVerticalSpace(24),
                  const AppText(text: 'No Classwork')
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: IzsFlatButton(
                  width: 200,
                  height: 45,
                  isResponsive: false,
                  color: AppColors.primaryColor,
                  text: 'Assign File',
                  textSize: 20,
                  textColor: Colors.black,
                  borderRadius: 8,
                  onPressed: () {
                    // Handle button press
                  },
                  borderColor: AppColors.primaryColor,
                  borderWidth: 0,
                ),
              ),
            ],
          ),
          addVerticalSpace(64),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppLargeText(text: 'ASSIGN MODULE'),
                  addVerticalSpace(24),
                  const AppText(text: 'No Module')
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: IzsFlatButton(
                  width: 200,
                  height: 45,
                  isResponsive: false,
                  color: AppColors.primaryColor,
                  text: 'Assign File',
                  textSize: 20,
                  textColor: Colors.black,
                  borderRadius: 8,
                  onPressed: () {
                    // Handle button press
                  },
                  borderColor: AppColors.primaryColor,
                  borderWidth: 0,
                ),
              ),
            ],
          ),
          addVerticalSpace(64),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppLargeText(text: 'QUIZ ASSIGNMENTS'),
                  addVerticalSpace(24),
                  const AppText(text: 'No Quiz Assignement')
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: IzsFlatButton(
                  width: 200,
                  height: 45,
                  isResponsive: false,
                  color: AppColors.primaryColor,
                  text: 'Assign File',
                  textSize: 20,
                  textColor: Colors.black,
                  borderRadius: 8,
                  onPressed: () {
                    // Handle button press
                  },
                  borderColor: AppColors.primaryColor,
                  borderWidth: 0,
                ),
              ),
            ],
          ),
          addVerticalSpace(64),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppLargeText(text: 'VIDEO QUIZ'),
                  addVerticalSpace(24),
                  const AppText(text: 'No Video Assignment')
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: IzsFlatButton(
                  width: 200,
                  height: 45,
                  isResponsive: false,
                  color: AppColors.primaryColor,
                  text: 'Assign File',
                  textSize: 20,
                  textColor: Colors.black,
                  borderRadius: 8,
                  onPressed: () {
                    // Handle button press
                  },
                  borderColor: AppColors.primaryColor,
                  borderWidth: 0,
                ),
              ),
            ],
          ),
          addVerticalSpace(64),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppLargeText(text: 'ASSIGNED VIDEO'),
                  addVerticalSpace(24),
                  const AppText(text: 'No Video Assignment')
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: IzsFlatButton(
                  width: 200,
                  height: 45,
                  isResponsive: false,
                  color: AppColors.primaryColor,
                  text: 'Assign File',
                  textSize: 20,
                  textColor: Colors.black,
                  borderRadius: 8,
                  onPressed: () {
                    // Handle button press
                  },
                  borderColor: AppColors.primaryColor,
                  borderWidth: 0,
                ),
              ),
            ],
          ),
          addVerticalSpace(64)
        ],
      ),
    );
  }
}
