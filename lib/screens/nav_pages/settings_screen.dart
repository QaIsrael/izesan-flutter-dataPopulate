import 'dart:async';
import 'dart:io';

import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/constants.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/utils/local_store.dart';
import 'package:izesan/widgets/app_large_text.dart';
import 'package:izesan/widgets/app_text.dart';
import 'package:izesan/widgets/icon_text.dart';
import 'package:izesan/widgets/line.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../locator.dart';
// import '../../model/notification_model.dart';
import '../../services/error_state.dart';
import '../../utils/route_name.dart';
import '../../utils/toast.dart';
import '../../viewmodels/verification_model.dart';
import '../../widgets/izs_header_text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  // final _ffsStorage = const FlutterSecureStorage();
  // final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final ErrorState _errorStateCtrl = locator<ErrorState>();

  /// Listen to the error stream
  late StreamSubscription<ErrorStatus> errorStateSub;
  // final Database db = Database as Database;
  String phone = '';
  String name = '';
  String userInitials = '';
  String email = '';

  currency(context) {
    NumberFormat format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    return format;
  }

  @override
  void initState() {
    super.initState();
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // getMeDetails().then((value) => getUserVerificationStatus());
    });
  }

  _showErrorMessage(event) {
    if (mounted) {
      var error = Provider.of<VerifyViewModel>(context, listen: false);
      if (error.errorMessage != null) {
        return CustomToastQueue.showCustomToast(
            context,
            error.errorMessage.toString(),
            Icons.close,
            AppColors.redTint,
            const Duration(seconds: toastDuration),
            'error');
      }
    }
  }


  // Future getMeDetails() async {
  //   var res = await context.read<HomePageModel>().getMeDetails();
  //   if (res == null) {
  //     return null;
  //   }
  //   return res;
  // }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed(RouteName.dashboard);
        return false;
      },
      child: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
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
              body: Semantics(
                label: 'List of Settings',
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      addVerticalSpace(10),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 4.0),
                          child: IzsHeaderText(
                            text: 'Settings',
                          ),
                        ),
                      ),
                      addVerticalSpace(23),
                      const Line(width: double.maxFinite),
                      addVerticalSpace(32),
                      const AppLargeText(
                        text: 'User Settings',
                        size: 14,
                      ),
                      addVerticalSpace(26),
                      TextWithIcon(
                        text: 'Class and Term Configuration',
                        onPress: () {
                          Navigator.of(context)
                              .pushNamed(RouteName.classTermConfigScreen);
                        },
                        child: SvgPicture.asset(
                          '/icons/verify.svg',
                        ),
                      ),
                      addVerticalSpace(10),
                      const Line(width: double.maxFinite),
                      addVerticalSpace(24),
                      const AppLargeText(
                        text: 'Preferences',
                        size: 14,
                      ),
                      addVerticalSpace(24),
                      TextWithIcon(
                        text: 'Appearance Display',
                        onPress: () {
                          // Navigator.of(context)
                          //     .pushNamed(RouteName.appearanceAndDisplay);
                        },
                        child:
                            SvgPicture.asset('/icons/theme_switch.svg'),
                      ),
                      addVerticalSpace(24),
                      const Line(width: double.maxFinite),
                      addVerticalSpace(24),
                      const AppLargeText(
                        text: 'More',
                        size: 14,
                      ),
                      addVerticalSpace(24),
                      TextWithIcon(
                        text: 'Terms of Use',
                        onPress: () {
                          _launchURL('https://izesan.com/terms-of-use');
                        },
                        child: SvgPicture.asset(
                          '/icons/T&C.svg',
                        ),
                      ),

                      TextWithIcon(
                        text: 'Logout',
                        onPress: () {
                          clearLocalStorage();
                          // db.close();
                        },
                        child: SvgPicture.asset(
                          '/icons/logout.svg',
                        ),
                      ),
                      addVerticalSpace(30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> clearLocalStorage() async {
    try {
      await LocalStoreHelper.removeUserToken();
      await LocalStoreHelper.removeGetMeDetails();
      LocalStoreHelper sessionManager = LocalStoreHelper();
      sessionManager.clearSession();

    } catch (e) {
      rethrow;
    }

    if (!mounted) return;

    try {
      await Navigator.of(context).pushNamedAndRemoveUntil(
          RouteName.welcomePage, (Route<dynamic> route) => false);
    } catch (e) {
      // Handle errors, log or show a message to the user
      print('Error navigating to welcome page: $e');
    }
  }
}
