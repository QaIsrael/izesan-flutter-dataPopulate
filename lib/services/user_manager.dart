import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class UserManager {
  SharedPreferences? prefs;

  UserManager() {
    initializePrefs();
  }

  Future<void> initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Future<bool> setLogin({required RegistrationResponse response, bool changeJWT = true}) async{
  //
  //   final String user = json.encode(response.user!.toJson());
  //
  //   await prefs!.setString(userKey,user);
  //
  //   if(changeJWT && response.authToken != null){
  //     await prefs!.setString(jwtKey,response.authToken!);
  //     int expiryTime = DateTime.now().add(const Duration(days: 90))
  //         .millisecondsSinceEpoch;
  //
  //     await prefs!.setInt(jwtKeyExpire, expiryTime);
  //   }
  //
  //   if(response.user!.phone != null) {
  //     await prefs!.setString(lastPhoneNumberKey, response.user!.phone!);
  //   }
  //
  //   return true;
  // }
  //
  // User? getUser() {
  //   String? userString = prefs!.getString(userKey);
  //   //print(userString);
  //   if(userString != null) {
  //     return User.fromJson(json.decode(userString));
  //   }
  //   return null;
  // }

  // Future<bool> saveUser(User user) async{
  //   final String userString = json.encode(user.toJson());
  //
  //   await prefs!.setString(userKey,userString);
  //   return true;
  // }
  //
  //
  // String? getToken() => prefs!.getString(jwtKey);
  //
  // String? getLastPhoneNumber() => prefs!.getString(lastPhoneNumberKey);

  // Future<bool> setLastPhoneNumber(String phone) async{
  //   await prefs!.setString(lastPhoneNumberKey, phone);
  //   return true;
  // }
  //
  // Future<bool> updateUser(User user) async{
  //   await prefs!.setString(
  //       userKey,
  //       json.encode(user.toJson())
  //   );
  //   return true;
  // }

  // Future<bool> updateAuthToken(String token) async{
  //   await prefs!.setString(jwtKey, token);
  //   return true;
  // }
  //
  // Future<bool> stillValid() async{
  //   int? expiryTime = prefs!.getInt(jwtKeyExpire);
  //   if(expiryTime! > DateTime.now().millisecondsSinceEpoch) {
  //     return true;
  //   }
  //   return false;
  // }

  // Future<bool> setNotificationToken(String token) async{
  //   await prefs!.setString(notificationKey, token);
  //   return true;
  // }
  //
  // Future<bool> setNotificationTokenSent(bool sent) async{
  //   await prefs!.setBool(notificationTokenSent2, sent);
  //   return true;
  // }

  // String? getNotificationToken() => prefs!.getString(notificationKey);
  //
  // bool? getNotificationTokenSent() => prefs!.getBool(notificationTokenSent2);
  //
  // Map<String, dynamic> getReminders(){
  //   var reminderString = prefs!.getString(reminderKey);
  //   if(reminderString != null) {
  //     return json.decode(reminderString);
  //   }
  //   return {};
  // }

  // Future<bool> setReminder(String reminderType, dynamic value) async{
  //   var reminders = getReminders();
  //   reminders[reminderType] = value;
  //   await prefs!.setString(reminderKey,json.encode(reminders));
  //   return true;
  // }


  // Future<bool> setShowShare(bool show) async{
  //   await prefs!.setBool(showShare, show);
  //   return true;
  // }

  // bool? getShowShare() => prefs!.getBool(showShare);

  Future<bool> logout() async {
    // await prefs!.remove(userKey);
    // await prefs!.remove(jwtKey);
    // await prefs!.remove(jwtKeyExpire);
    // await prefs!.remove(notificationKey);
    // await prefs!.remove(notificationTokenSent2);
    // await prefs!.remove(reminderKey);
    return true;
  }
}
