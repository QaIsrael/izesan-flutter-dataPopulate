import 'package:flutter_svg/svg.dart';
import 'package:izesan/screens/home_page/home_page.dart';
import 'package:izesan/screens/nav_pages/profile_screen.dart';
import 'package:izesan/screens/nav_pages/settings_screen.dart';
import 'package:izesan/screens/nav_pages/teachers.dart';
import 'package:izesan/screens/nav_pages/students.dart';
import 'package:izesan/screens/nav_pages/classes.dart';
import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/local_store.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/route_name.dart';
import '../../viewmodels/base_model.dart';
import '../../viewmodels/verification_model.dart';
import '../../widgets/app_text.dart';
import '../settings_page/secure_account_dialog.dart';
import 'app_drawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  // final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  late SecureDialogBoxHandler _securePaymentHandler;

  /// This global key is used to access the state of the navigator
  ///associated with the WillPopScope.
  /// It allows you to manipulate the navigation stack.
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  List<Widget> pages = [
    const Profile(),
    const ManageClasses(),
    const Students(),
    const TeachersScreen(),
    const SettingsScreen(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
    // Execute additional actions based on the selected tab
    // switch (currentIndex) {
    //   case 0:
    //     break;
    //   case 1:
    //     // getUserVerificationStatus();
    //     break;
    //   case 2:
    //     // getUserVerificationStatus();
    //     break;
    //   case 3:
    //     break;
    // }
  }

  // Future<void> getUserVerificationStatus() async {
  //   var verifyModel = Provider.of<VerifyViewModel>(context, listen: false);
  //   for (var verificationStatus in verifyModel.verificationStatus) {
  //     if (verificationStatus.code!.contains('password') &&
  //         verificationStatus.status == false) {
  //       return _securePaymentHandler.show();
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double drawerWidth = (screenWidth * 0.55).clamp(100.0, 200.0);

    Color selectedColor = AppColors.primaryColor;
    Color unselectedColor = AppColors.warningColor;

    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            Container(
              width: drawerWidth,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: const AppText(text: 'John Doe'),
                    accountEmail: const AppText(text: 'user@izesan.com'),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  ListTile(
                    leading: SizedBox(
                      width: 32,
                      height: 32,
                      child: SvgPicture.asset(
                        "/icons/profile.svg",
                        width: 32,
                        height: 32,
                      ),
                    ),
                    title:  AppText(text: 'Profile',
                      color: currentIndex == 0 ? selectedColor : unselectedColor,
                    ),
                    selected: currentIndex == 0,
                    selectedTileColor: selectedColor.withOpacity(0.1),
                    onTap: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                  ),
                  ListTile(
                    leading: SizedBox(
                      width: 32,
                      height: 32,
                      child: SvgPicture.asset(
                        "/icons/classroom.svg",
                        width: 32,
                        height: 32,
                      ),
                    ),
                    title:  AppText(text: 'Class',
                      color: currentIndex == 1 ? selectedColor
                          : unselectedColor,),
                    selected: currentIndex == 1,
                    selectedTileColor: selectedColor.withOpacity(0.1),
                    onTap: () {
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                  ),
                  ListTile(
                    leading: SizedBox(
                    width: 32,
                    height: 40,
                    child: SvgPicture.asset(
                      "/icons/class-stud.svg",
                      width: 32,
                      height: 32,
                    ),
                  ),
                    title: AppText(text: 'Student',
                      color: currentIndex == 2 ? selectedColor : unselectedColor,
                    ),
                    selected: currentIndex == 2,
                    selectedTileColor: selectedColor.withOpacity(0.1),
                    onTap: () {
                      setState(() {
                        currentIndex = 2;
                      });
                    },
                  ),
                  ListTile(
                    leading: SizedBox(
                      width: 32,
                      height: 32,
                      child: SvgPicture.asset(
                        "/icons/learning.svg",
                        width: 32,
                        height: 32,
                      ),
                    ),
                    title:  AppText(text:'Teachers',
                      color: currentIndex == 3 ? selectedColor : unselectedColor,
                    ),
                    selected: currentIndex == 3,
                    selectedTileColor: selectedColor.withOpacity(0.1),
                    onTap: () {
                      setState(() {
                        currentIndex = 3;
                      });
                    },
                  ),
                  ListTile(
                    leading: SizedBox(
                      width: 32,
                      height: 32,
                      child: SvgPicture.asset(
                        "/icons/settings.svg",
                        width: 32,
                        height: 32,
                      ),
                    ),
                    title:  AppText(text:'Settings',
                      color: currentIndex == 4 ? selectedColor : unselectedColor,
                    ),
                    selected: currentIndex == 4,
                    selectedTileColor: selectedColor.withOpacity(0.1),
                    onTap: () {
                      setState(() {
                        currentIndex = 4;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: currentIndex,
                children: pages,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).primaryColor,
          selectedFontSize: 14.0,
          unselectedFontSize: 14.0,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w300),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          elevation: 4,
          items:  [
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SvgPicture.asset(
                  "/icons/profile.svg",
                  width: 32,
                  height: 32,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Class',
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: SvgPicture.asset(
                  "/icons/classroom.svg",
                  width: 32,
                  height: 32,
                ),
              ),
            ),
             BottomNavigationBarItem(
              label: 'Students',
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SvgPicture.asset(
                  "/icons/class-stud.svg",
                  width: 32,
                  height: 32,
                ),
              ),
            ),
             BottomNavigationBarItem(
              label: 'Teachers',
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SvgPicture.asset(
                  "/icons/learning.svg",
                  width: 32,
                  height: 32,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SvgPicture.asset(
                  "/icons/settings.svg",
                  height: 30,
                  width: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
