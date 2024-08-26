
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widgets/app_text.dart';

class GradeBookTabBar extends StatefulWidget {
  @override
  _GradeBookTabBarState createState() => _GradeBookTabBarState();
}

class _GradeBookTabBarState extends State<GradeBookTabBar> with SingleTickerProviderStateMixin {
  late TabController _gradeBookTabController;

  @override
  void initState() {
    super.initState();
    _gradeBookTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _gradeBookTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TabBar(
            controller: _gradeBookTabController,
            dividerHeight: 40.0,
            dividerColor: Colors.transparent,
            labelPadding: const EdgeInsets.only(left: 20, right: 20),
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.primaryColor,
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
            tabs:  const [
              Tab(
                height: 38,
                child: AppText(
                  text: 'Classwork Grade',
                  size: 16,
                  fontWeight: FontWeight.w900,
                  color: AppColors.warningColor,
                ),
              ),
              Tab(
                height: 38,
                child: AppText(
                  text: 'Quiz Grade',
                  size: 16,
                  fontWeight: FontWeight.w900,
                  color: AppColors.warningColor,
                ),
              ),
              Tab(
                height: 38,
                child: AppText(
                  text: 'Video Quiz Grade',
                  size: 16,
                  fontWeight: FontWeight.w900,
                  color: AppColors.warningColor,
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _gradeBookTabController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                Center(child: Text('Classwork Grade Content')),
                Center(child: Text('Quiz Grade Content')),
                Center(child: Text('Video Quiz Grade Content')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}