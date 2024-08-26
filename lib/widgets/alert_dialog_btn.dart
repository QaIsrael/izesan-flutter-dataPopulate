import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';
import '../utils/helper_widgets.dart';
import 'izs_flat_button.dart';

class AlertDialogBtn extends StatelessWidget {
  // final double width;
  // final double height;
  final double borderRadius;
  final Color color;
  final Color cardColor;
  final Color? borderColor;
  final String alertTitle;
  final String alertMessage;
  final double titleSize;
  final double messageSize;
  final Function keepButton;
  final Function deleteButton;
  final String btnKeepText;
  final String btnDeleteText;
  final bool isLoading;

  const AlertDialogBtn({
    super.key,
    // this.width = 320,
    // this.height = 175,
    required this.borderRadius,
    required this.color,
    required this.cardColor,
    this.borderColor = AppColors.cardColor,
    required this.alertMessage,
    required this.alertTitle,
    required this.titleSize,
    required this.messageSize,
    required this.keepButton,
    required this.deleteButton,
    this.btnKeepText = 'Keep',
    this.btnDeleteText = 'Delete',
    this.isLoading = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 320,
        height: 175,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16.0),
          // border: Border.all(color: borderColor!, width: 4.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.5,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0.0,
              offset: Offset(0.4, 0.4), // shadow direction: bottom right
            )
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addVerticalSpace(24),
                    Text(
                      alertTitle,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.nunitoSans(
                          fontSize: titleSize,
                          color: color,
                          fontWeight: FontWeight.bold),
                    ),
                    addVerticalSpace(8),
                    Text(
                      alertMessage,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.nunitoSans(
                        fontSize: messageSize,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColorSecondary,
                      ),
                    ),
                  ],
                ),
                addVerticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IzsFlatButton(
                        // width: 66,
                        height: 32,
                        borderWidth: 1,
                        borderColor: AppColors.borderColor,
                        textColor: AppColors.primaryColor,
                        color: Colors.white,
                        text: btnKeepText,
                        textSize: 14,
                        onPressed: () {
                          return keepButton();
                        },
                        borderRadius: 8),
                    IzsFlatButton(
                        isLoading: isLoading,
                        // width: isLoading ? 120 : 76,
                        height: 32,
                        borderWidth: 0,
                        borderColor: AppColors.errorColor2,
                        textColor: AppColors.textColor2,
                        color: AppColors.errorColor,
                        text: btnDeleteText,
                        textSize: 14,
                        onPressed: () {
                          return deleteButton();
                        },
                        borderRadius: 8),
                  ],
                ),
              ],
            )));
  }
}
