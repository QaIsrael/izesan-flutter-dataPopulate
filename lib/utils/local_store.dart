import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_details.dart';

enum AuthStatus { LOGGED_IN, LOGGED_OUT, IS_LOADING }

enum ErrorStatus { ERROR, SUCCESS }

enum UserType { VERIFIED, UNVERIFIED }

const _appConfigKey = 'app_config';
const authTokenKey = 'auth_token';
const profileKey = 'profile';
const USER_VERIFY_STATUS = 'user_verify_status';
const PASSWORD_VERIFY = 'profile';
const USER_PROFILE = 'user_profile';
const AUTH_USER_TYPE = 'user_type';
const USER_DETAILS = 'user_details';
const FAVOURITE_STATUS = 'favourite_status';
const USER_THEME = "user_theme";
const SYSTEM_THEME = "system_theme";

const String _userTypeKey = 'userType';
const String _schoolUserKey = 'schoolUser';
const String _teacherUserKey = 'teacherUser';
const String _studentUserKey = 'studentUser';
const String _parentUserKey = 'parentUser';



class LocalStoreHelper {
final _secureStorage = FlutterSecureStorage();
final _keyStorageKey = 'encryption_key';

  static saveInfo(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(authTokenKey, token);
  }

  static Future<String> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(authTokenKey) ?? '';
  }

  static Future<bool> removeUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(authTokenKey);
  }

  //Dynamically save the user
  Future<void> saveUser(String userType, dynamic user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userTypeKey, userType);

    switch (userType) {
      case 'School':
        prefs.setString(_schoolUserKey, jsonEncode(user.toJson()));
        break;
      case 'Teacher':
        prefs.setString(_teacherUserKey, jsonEncode(user.toJson()));
        break;
      case 'Student':
        prefs.setString(_studentUserKey, jsonEncode(user.toJson()));
        break;
      case 'Parent':
        prefs.setString(_parentUserKey, jsonEncode(user.toJson()));
        break;
    }
  }

  Future<Map<String, dynamic>?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString(_userTypeKey);

    if (userType == null) {
      return null;
    }

    String? userData;
    switch (userType) {
      case 'School':
        userData = prefs.getString(_schoolUserKey);
        break;
      case 'Teacher':
        userData = prefs.getString(_teacherUserKey);
        break;
      case 'Student':
        userData = prefs.getString(_studentUserKey);
        break;
      case 'Parent':
        userData = prefs.getString(_parentUserKey);
        break;
      default:
        return null;
    }

    if (userData == null) {
      return null;
    }

    return {
      'userType': userType,
      'userData': jsonDecode(userData),
    };
  }

  Future<void> clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_userTypeKey);
    prefs.remove(_schoolUserKey);
    prefs.remove(_teacherUserKey);
    prefs.remove(_studentUserKey);
    prefs.remove(_parentUserKey);
  }

  // static saveUserInfo(User user) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(USER_PROFILE, jsonEncode(user.toJson()));
  // }

  // static Future<User?> getUserInfo() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final userInfoString = prefs.getString(USER_PROFILE) ?? '';
  //   if (userInfoString.isNotEmpty) {
  //     final Map<String, dynamic> userMap = jsonDecode(userInfoString);
  //     return User.fromJson(userMap);
  //   }
  //   return null;
  // }

  static saveMeDetails(UserData meDetail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(profileKey, jsonEncode(meDetail.toJson()));
  }

  static Future<UserData?> getMeDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userInfoString = prefs.getString(profileKey) ?? '';
    if (userInfoString.isNotEmpty) {
      final Map<String, dynamic> meDetails = jsonDecode(userInfoString);
      return UserData.fromJson(meDetails);
    }
    return UserData.fromJson({});
  }

  // static Future<void> saveUserLocation(
  //     double latitude, double longitude) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setDouble('latitude', latitude);
  //   await prefs.setDouble('longitude', longitude);
  // }

  // static Future<Map<String, double>> getLocation() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   double latitude = prefs.getDouble('latitude') ?? 0.0;
  //   double longitude = prefs.getDouble('longitude') ?? 0.0;
  //   return {"latitude": latitude, "longitude": longitude};
  // }

  static Future<bool> removeGetMeDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(profileKey);
  }

  static saveUserType(item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AUTH_USER_TYPE, item);
  }

  static Future<String> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AUTH_USER_TYPE) ?? '';
  }

  ///Persist user's system theme, and set the default to true
  static Future<bool> setSystemThemeSettings(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(SYSTEM_THEME, value);
  }

  static Future<bool> getSystemThemeSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SYSTEM_THEME) ?? true;
  }

  static Future<bool> setTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(USER_THEME, value);
  }

  static getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(USER_THEME);
  }

  static isAuth() async {
    final token = await getUserToken();
    return token.isNotEmpty ? AuthStatus.LOGGED_IN : AuthStatus.LOGGED_OUT;
  }

  // check if the user was verified or if the temp.
  static isVerified() async {
    final checkUser = await getUserType();
    return checkUser.isNotEmpty ? UserType.VERIFIED : UserType.UNVERIFIED;
  }


  // Persist state for user first time review
  static saveUserReviewCount(review) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('firstReview', review);
  }

  static Future getUserReviewCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('firstReview') ?? 0;
  }

  // Generate and store encryption key
  Future<void> initializeEncryptionKey() async {
    String? key = await _secureStorage.read(key: _keyStorageKey);
    if (key == null) {
      final newKey = encrypt.Key.fromSecureRandom(32);
      await _secureStorage.write(key: _keyStorageKey, value: newKey.base64);
    }
  }

}
