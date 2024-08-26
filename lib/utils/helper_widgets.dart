import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_theme.dart';
import '../widgets/app_large_text.dart';
import '../widgets/app_text.dart';
import 'colors.dart';

final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
String naira = String.fromCharCodes(Runes('\u{20A6}'));

const double squareSize = 60.0;
const int length = 3;
const double strokeWidth = 250.0;
const double strokeHeight = 10.0;
const double spacing = 8.0;

String timeAgo(DateTime notificationDate) {
  DateTime currentDate = DateTime.now();

  var different = currentDate.difference(notificationDate);

  if (different.inDays > 365) {
    return "${(different.inDays / 365).floor()} ${(different.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  }
  if (different.inDays > 30) {
    return "${(different.inDays / 30).floor()} ${(different.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  }
  if (different.inDays > 7) {
    return "${(different.inDays / 7).floor()} ${(different.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (different.inDays > 0) {
    return "${different.inDays} ${different.inDays == 1 ? "day" : "days"} ago";
  }
  if (different.inHours > 0) {
    return "${different.inHours} ${different.inHours == 1 ? "hour" : "hours"} ago";
  }
  if (different.inMinutes > 0) {
    return "${different.inMinutes} ${different.inMinutes == 1 ? "minute" : "minutes"} ago";
  }
  if (different.inMinutes == 0) return 'Just Now';

  return notificationDate.toString();
}

Widget addVerticalSpace(double height) {
  return SizedBox(height: height);
}

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget detailsBreakdown(String text, String value) {
  num amount = double.parse(value);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      AppText(
        color: AppColors.textColorSecondary,
        text: text,
        size: 14,
      ),
      AppLargeText(
          text: (NumberFormat.currency(name: 'NGN', symbol: naira))
              .format(amount),
          size: 16),
    ],
  );
}


Widget? getNotificationIcon(String? topic, Map<String?, String> topicToImage) {
  if (topic == null) {
    // Use a default image when the topic is null
    return SizedBox(
      child: Image.asset(
        'assets/icons/promo_icon.png',
        height: 5,
        width: 5,
        fit: BoxFit.contain,
      ),
    );
  } else {
    String? imageAsset = topicToImage[topic.toUpperCase()];

    if (imageAsset == null) {
      // Add a new mapping with the default image asset path for the new topic
      topicToImage[topic.toUpperCase()] =
          "assets/images/default_${topic.toLowerCase()}.png";

      // Use the new mapping with the default image asset path
      imageAsset = topicToImage[topic.toUpperCase()]!;
    }

    return SizedBox(
      child: Image.asset(
        imageAsset,
        height: 5,
        width: 5,
        fit: BoxFit.contain,
      ),
    );
  }
}

Widget bankCardImage(String type) {
  String assetPath;
  switch (type) {
    case 'visa':
      assetPath = 'assets/images/visa.png';
      break;
    case 'mastercard':
      assetPath = 'assets/icons/mastercard-icon.svg';
      break;
    case 'verve':
      assetPath = 'assets/images/verve.png';
      break;
    default:
      assetPath = 'assets/icons/mastercard-icon.svg';
  }

  return SizedBox(
    width: 24,
    height: 24,
    child: assetPath.endsWith('.svg')
        ? SvgPicture.asset(assetPath)
        : Image.asset(assetPath),
  );
}

BoxShadow generateBoxShadow(BuildContext context) {
  final isDarkMode = Provider.of<AppTheme>(context).themeMode == ThemeMode.dark;
  final isLightMode = Provider.of<AppTheme>(context).themeMode == ThemeMode.dark;
  if(isDarkMode == true) {
    return BoxShadow(
      color: Theme.of(context).primaryColor,
      blurRadius: 5.0,
      blurStyle: BlurStyle.normal,
      spreadRadius: 0.0,
      offset: const Offset(0.0, 0.2),
    );
  }
  if(isLightMode == true) {
    return const BoxShadow(
      color: AppColors.shadowColor,
      blurRadius: 5.0,
      blurStyle: BlurStyle.normal,
      spreadRadius: 0.0,
      offset: Offset(0.0, 0.2),
    );
  }
  return BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 5.0,
    blurStyle: BlurStyle.normal,
    spreadRadius: 0.0,
    offset: const Offset(0.0, 0.2),
  );
}

Widget buildLoader() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[400]!,
    highlightColor: Colors.grey[300]!,
    child: SizedBox(
      // height: 200,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: squareSize,
            height: squareSize,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          addHorizontalSpace(8),
          Column(
            children: [
              Container(
                width: strokeWidth,
                height: strokeHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              const SizedBox(height: spacing),
              Container(
                width: strokeWidth,
                height: strokeHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              const SizedBox(height: spacing),
              Container(
                width: strokeWidth,
                height: strokeHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
