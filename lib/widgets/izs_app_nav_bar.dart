import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../utils/helper_widgets.dart';
import '../utils/route_name.dart';
import 'izs_flat_button.dart';

class LoginNavBar extends StatelessWidget {
  final double? width;
  final double? height;
  // final Color color;

  const LoginNavBar(
      {Key? key,
        this.width = double.maxFinite,
        this.height = 70,
        // this.color = AppColors.captionColor
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const isWeb = kIsWeb;

    final double verticalPadding = MediaQuery.of(context).size.height * 0.06;
    final double horizontalPadding = MediaQuery.of(context).size.width * 0.05;
    return Padding(
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
                  onPressed: () {
                    // _handleLogin();
                    Navigator.of(context).pushNamed(RouteName.login, arguments: {
                      'phone': '',
                      'name': 'Izesan'
                    });
                    },
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
                  onPressed: () {
                    // _handleGotoFreeVersion();
                    Navigator.of(context).pushNamed(RouteName.login, arguments: {
                      'phone': '',
                      'name': 'Izesan'
                    });
                    },
                  borderColor: Theme.of(context).cardColor,
                  borderWidth: 0,
                )
              ],
            )
          ],
        ),
      ),
    );

  }
}
