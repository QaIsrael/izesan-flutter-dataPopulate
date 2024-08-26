import 'package:izesan/utils/colors.dart';
import 'package:izesan/utils/local_store.dart';
import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  late ThemeMode themeMode;

  AppTheme() {
    themeMode = ThemeMode.light;
    init();
  }

  init() async {
    var appTheme = await LocalStoreHelper.getTheme();
    switch (appTheme) {
      case true:
        themeMode = ThemeMode.dark;
        toggleTheme(themeMode);
        break;
      case false:
        themeMode = ThemeMode.light;
        toggleTheme(themeMode);
        break;
      default:
        themeMode = ThemeMode.system;
    }
    notifyListeners();
  }


  bool get isDarkMode => themeMode == ThemeMode.dark;
  bool get isLightMode => themeMode == ThemeMode.light;
  bool get isSystemMode => themeMode == ThemeMode.system;

  void toggleTheme(ThemeMode themeChange) {
      LocalStoreHelper.setTheme(themeChange == ThemeMode.dark ? true : false);
    if (themeChange == ThemeMode.dark) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  toggleSystemTheme(bool isSystemTheme) {
    LocalStoreHelper.setSystemThemeSettings(isSystemTheme);
    if (isSystemTheme == true) {
      themeMode = ThemeMode.system;
    } else if(isSystemTheme == false){
      init();
    }
    notifyListeners();
  }

  static final lightTheme = ThemeData(
    // colorScheme: ColorScheme(brightness: brightness, ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: AppColors.primaryNavColorLight,
    brightness: null,
    canvasColor: Colors.black,
    shadowColor: AppColors.shadowColor,
    dividerColor: AppColors.captionColor,
    scaffoldBackgroundColor: AppColors.bgColorLightTheme,
    primaryColorDark: AppColors.textColorLightTheme,
    cardColor: AppColors.cardColor,
    highlightColor: AppColors.primaryColor.withOpacity(0.5),
    focusColor:
        AppColors.focusColor, //favorite card color for electricity
    splashColor: AppColors.primaryColor
        .withOpacity(0.2), //favorite card color for airtime
    hoverColor: AppColors.hoverColor, //favorite card color for cable
    indicatorColor: AppColors.indicatorColor, //favorite card color for data
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24.0,
        fontFamily: 'NunitoSans',
        fontWeight: FontWeight.w700,
        color: AppColors.bodyTextColorLightTheme,
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        fontFamily: 'NunitoSans',
        fontWeight: FontWeight.bold,
        color: AppColors.bodyTextColorLightTheme,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontFamily: 'NunitoSans',
        fontWeight: FontWeight.w400,
        color: AppColors.bodyTextColorLightTheme,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.0,
        fontFamily: 'NunitoSans',
        fontWeight: FontWeight.w400,
        color: AppColors.bodyTextColorLightTheme,
      ),
      bodySmall: TextStyle(
        fontSize: 14.0,
        fontFamily: 'NunitoSans',
        fontWeight: FontWeight.w400,
        color: AppColors.bodyTextColorLightTheme,
      ),
      labelLarge: TextStyle(
        fontSize: 15.0,
        fontFamily: 'NunitoSans',
        fontWeight: FontWeight.w500,
        color: AppColors.bodyTextColorLightTheme,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
        .copyWith(background: AppColors.bgColorLightTheme),
    cardTheme: CardTheme(
      shadowColor: Colors.grey.withOpacity(0.5),
      elevation: 10,
    ),
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
              color: AppColors.bodyTextColorLightTheme
          )
      )
  );
  static final darkTheme = ThemeData(
      // colorScheme: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardColor: AppColors.cardColorDarkTheme,
      scaffoldBackgroundColor: AppColors.bgColorDarkTheme,
      primaryColor: Colors.black,
      brightness: null,
      dividerColor: AppColors.captionColor,
      canvasColor: Colors.white,
      shadowColor: AppColors.shadowColor,
      highlightColor: AppColors.primaryColor.withOpacity(0.5),
      focusColor: AppColors.focusColorDark, //favorite card color for electricity
      splashColor: AppColors.primaryColor.withOpacity(0.1),
      hoverColor: AppColors.hoverColorDark, //favorite card color for cable
      indicatorColor: AppColors.indicatorColorDark, //favorite card color for data
      primaryColorDark: AppColors.captionColor,
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontSize: 24.0,
          fontFamily: 'NunitoSans',
          fontWeight: FontWeight.w700,
          color: AppColors.bodyTextColorDarkTheme,
        ),
        titleMedium: TextStyle(
          fontSize: 16.0,
          fontFamily: 'NunitoSans',
          fontWeight: FontWeight.w700,
          color: AppColors.bodyTextColorDarkTheme,
        ),
        bodyLarge: TextStyle(
          fontSize: 17.0,
          fontFamily: 'NunitoSans',
          fontWeight: FontWeight.bold,
          color: AppColors.bodyTextColorDarkTheme,
        ),
        bodyMedium: TextStyle(
          fontSize: 15.0,
          fontFamily: 'NunitoSans',
          fontWeight: FontWeight.w400,
          color: AppColors.bodyTextColorDarkTheme,
        ),
        bodySmall: TextStyle(
          fontSize: 14.0,
          fontFamily: 'NunitoSans',
          fontWeight: FontWeight.w400,
          color: AppColors.bodyTextColorDarkTheme,
        ),
        labelLarge: TextStyle(
          fontSize: 15.0,
          fontFamily: 'NunitoSans',
          fontWeight: FontWeight.w500,
          color: AppColors.bodyTextColorDarkTheme,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
          .copyWith(background: const Color(0xFF000000)),
      cardTheme: CardTheme(
        shadowColor: Colors.black.withOpacity(0.5),
        elevation: 10,),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: AppColors.bgColorLightTheme
        )
      )
  );
}

