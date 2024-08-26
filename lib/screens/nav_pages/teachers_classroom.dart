import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:izesan/widgets/izs_checkbox.dart';

import '../../utils/constants.dart';
import '../../widgets/app_text.dart';
import '../../widgets/izs_flat_button.dart';
import '../../widgets/izs_header_text.dart';
import '../classroom_widget/assessment_view.dart';
import '../classroom_widget/grade_book_tabbar.dart';
import '../classroom_widget/student_listview.dart';

class TeachersClassRoom extends StatefulWidget {
  const TeachersClassRoom({super.key});

  @override
  State<TeachersClassRoom> createState() => _TeachersClassRoomState();
}

class _TeachersClassRoomState extends State<TeachersClassRoom> with SingleTickerProviderStateMixin {
  late TabController _mainTabController;

  late List<dynamic> tableData = [
    {'id': 1, 'Name': 'John Albert', 'Gender': 'Male', },
    {'id': 2, 'Name': 'Dihweng Doe', 'Gender': 'Male', },
    {'id': 3, 'Name': 'Kelvin Albert', 'Gender': 'Male',},
    {'id': 4, 'Name': 'Sam Marcos', 'Gender': 'Male',},
  ];

  @override
  void initState() {
    super.initState();
    _mainTabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
          title: const Align(
              alignment: Alignment.centerLeft,
              child: IzsHeaderText(text: 'Primary 1a')),
        ),
        body: Column(
          children: <Widget>[
            // Container(
            //     width: screenWidth * 0.9,
            //     height: 50,
            //     margin: EdgeInsets.only(top: 24),
            //     padding: const EdgeInsets.only(left: 24),
            //     decoration: BoxDecoration(
            //       color: Theme.of(context).cardColor,
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: const Align(
            //         alignment: Alignment.centerLeft,
            //         child: IzsHeaderText(text: 'Primary 1a'))),
            // addVerticalSpace(24),
            TabBar(
              controller: _mainTabController,
              dividerHeight: 40.0,
              dividerColor: Colors.transparent,
              labelColor: AppColors.gloGreen,
              unselectedLabelColor: AppColors.captionColor,
              labelPadding: const EdgeInsets.only(left: 20, right: 20),
              indicatorSize: TabBarIndicatorSize.tab,
              padding: const EdgeInsets.only(left: 30, right: 30, bottom :24),
              // isScrollable: true,
              // tabAlignment: TabAlignment.start,
              tabs: const [
                Tab(
                  height: 80,
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.school),
                      SizedBox(height: 5),
                      Text('Students')
                    ],
                  ),
                ),
                Tab(
                  height: 80,
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_add_alt_outlined),
                      SizedBox(height: 5),
                      Text('Assessment')
                    ],
                  ),
                ),
                Tab(
                  height: 80,
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.menu_book_sharp),
                      SizedBox(height: 5),
                      Text('Gradebook')
                    ],
                  ),
                ),
                Tab(
                  height: 80,
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.settings),
                      SizedBox(height: 5),
                      Text('Settings')
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _mainTabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                 Align(
                     alignment: Alignment.topCenter,
                     child: SizedBox(width: screenWidth * 0.90,
                     child: MyListView(data: tableData),)),
                  Align(
                     alignment: Alignment.topCenter,
                     child: SizedBox(width: screenWidth * 0.90,
                     child: AssessmentView(data: tableData),)),
                  GradeBookTabBar(),
                  const Center(child: AppText(text: 'Settings Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}



// class LearningResourcesData {
//   final String? name;
//   final String? image;
//
//   LearningResourcesData({this.name, this.image});
// }
