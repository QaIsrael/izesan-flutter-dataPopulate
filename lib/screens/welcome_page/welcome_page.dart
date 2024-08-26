import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:izesan/utils/helper_widgets.dart';
import 'package:izesan/utils/local_store.dart';
import 'package:izesan/utils/route_name.dart';
import 'package:izesan/widgets/app_large_text.dart';
import 'package:izesan/widgets/app_text.dart';
import 'package:izesan/widgets/izs_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../locator.dart';
import '../../services/error_state.dart';
import '../../utils/colors.dart';
import '../../utils/image_url.dart';
import '../../utils/toast.dart';
import '../../viewmodels/auth_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final ErrorState _errorStateCtrl = locator<ErrorState>();
  //Listen to the error stream
  late StreamSubscription<ErrorStatus> errorStateSub;
  // final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  final List<String> errors = [];

  @override
  void initState() {
    super.initState();
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
    errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
    context.read<AuthViewModel>().clearError();
  }

  @override
  void dispose() {
    super.dispose();
    errorStateSub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    const isWeb = kIsWeb;

    final double verticalPadding = MediaQuery.of(context).size.height * 0.06;
    final double horizontalPadding = MediaQuery.of(context).size.width * 0.05;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Padding(
               padding: EdgeInsets.symmetric(
                   vertical: 24,
                   horizontal: horizontalPadding),
               child: SizedBox(
                 height: 80,
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child:  Image.asset('assets/images/logo.png',
                        fit: BoxFit.contain,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Row(
                      children: [
                        IzsFlatButton(
                          width: 100,
                          height: 40,
                          isResponsive: false,
                          color: AppColors.warningColor,
                          text: 'Login',
                          textSize: 14,
                          textColor: Colors.white,
                          borderRadius: 8,
                          onPressed: () {_handleLogin();},
                          borderColor: Theme.of(context).cardColor,
                          borderWidth: 0,
                        ),
                        addHorizontalSpace(40),
                        IzsFlatButton(
                          width: 150,
                          height: 40,
                          isResponsive: false,
                          color: AppColors.warningCaption,
                          text: 'Free Version',
                          textSize: 14,
                          textColor: Colors.white,
                          borderRadius: 8,
                          onPressed: () {_handleGotoFreeVersion();},
                          borderColor: Theme.of(context).cardColor,
                          borderWidth: 0,
                        )
                      ],
                    )
                  ],
                 ),
               ),
             ),

            Expanded(
              child: Container(
                width: double.maxFinite,
                color: AppColors.warningColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: verticalPadding,
                      horizontal: horizontalPadding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: screenHeight * 0.6,

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Welcome to ',
                                    style: GoogleFonts.nunitoSans(
                                      color: AppColors.bodyTextColorDarkTheme,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w500,
                                      textStyle:
                                      Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Izesan!',
                                        style: GoogleFonts.nunitoSans(
                                          color: AppColors.bodyTextColorDarkTheme,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                          textStyle:
                                          Theme.of(context).textTheme.bodyLarge,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                  addVerticalSpace(24),
                                  SizedBox(
                                    width: screenWidth * 0.4,
                                    child: const AppLargeText(
                                      color: AppColors.textColor2,
                                      text: 'Where tradition meets technology in language learning!',
                                      size: 28,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  addVerticalSpace(40),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4, // Adjust width for mobile
                                    // height: 72,
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(16.0), // Border radius
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const AppLargeText(
                                              text:'Choose from 14 languages',
                                              size: 20,
                                            ),
                                            IzsFlatButton(
                                              width: 120,
                                              height: 40,
                                              isResponsive: false,
                                              color: AppColors.warningColor,
                                              text: 'Join Now',
                                              textSize: 20,
                                              textColor: Colors.white,
                                              borderRadius: 8,
                                              onPressed: () {_handleLogin();},
                                              borderColor: AppColors.warningColor,
                                              borderWidth: 0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  addVerticalSpace(24),
                                  SizedBox(
                                      width: screenWidth * 0.4,
                                      child: const AppText(
                                        text: 'Embark on a transformative journey with Izesan!, a pioneering e-learning platform designed to bring the richness of indigenous languages directly to your fingertips.',
                                        color: AppColors.bodyTextColorDarkTheme,
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 40),
                            height: 400.0,
                            child: Center(
                              child: SizedBox(
                                // child: SvgPicture.asset(
                                //   '/images/map.svg',
                                //   width: 498,
                                //   height: 380
                                // ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          addVerticalSpace(10),
                          SizedBox(
                            width: 298,
                            // height: 50,
                            child: Column(
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () => _launchURL(
                                      'https://izesan.com/terms-of-use'),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: 'By continuing, you agree to our ',
                                        style: GoogleFonts.nunitoSans(
                                          // color: color,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          textStyle:
                                          Theme.of(context).textTheme.bodyLarge,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Terms Of Use',
                                            style: GoogleFonts.nunitoSans(
                                              color: AppColors.secondaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              textStyle:
                                              Theme.of(context).textTheme.bodyLarge,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () => _launchURL(
                                      'https://izesan.com/privacy-policy'),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:4.0),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: 'and our ',
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          textStyle:
                                          Theme.of(context).textTheme.bodyLarge,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ' Privacy Policy',
                                            style: GoogleFonts.nunitoSans(
                                              color: AppColors.secondaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              textStyle:
                                              Theme.of(context).textTheme.bodyLarge,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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

  _showErrorMessage(event) {
    if(mounted){
      var error = Provider.of<AuthViewModel>(context, listen: false);
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

  Future<void> _handleLogin() async {
    await Navigator.of(context).pushNamed(RouteName.login, arguments: {
      'phone': '',
      'name': 'Izesan'
    });
  }

  Future<void> _handleGotoFreeVersion() async {
    await Navigator.of(context).pushNamed(RouteName.login, arguments: {});
  }

}
