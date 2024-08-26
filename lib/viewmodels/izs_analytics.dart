import 'package:izesan/services/auth_services.dart';
import 'package:izesan/services/izs_log_service.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../locator.dart';
import '../services/auth_services.dart';
import 'base_model.dart';

// import '../resources/local_storage_manager.dart';
// import '../resources/networking/api_service.dart';

/// Class to prepare analytics for sending
class IzsAnalytics extends BaseViewModel {
  static const network = "NETWORK";
  static const action = "ACTION";
  static const page = "PAGE";
  static const timing = "TIMING";
  static const payment = "PAYMENT";

  static const userAgent = "USER_AGENT";
  AuthService authService = locator<AuthService>();
  // IzsLogService izsLogService = locator<IzsLogService>();

  IzsAnalytics();

  Map<String, dynamic> prepareBody(
      {required category, required action, label, value}) {
    Map<String, String> jsonMap = {};
    jsonMap['category'] = category;
    jsonMap['action'] = action;
    if (label != null) {
      jsonMap['label'] = label;
    }
    if (value != null) {
      jsonMap['value'] = value;
    }
    return jsonMap;
  }

  Map<String, dynamic> preparePaymentBody(
      {name, ref, value, error, success, user}) {
    Map<String, String> jsonMap = {};
    if (name != null) {
      jsonMap['name'] = name;
    }
    if (ref != null) {
      jsonMap['ref'] = ref;
    }
    if (value != null) {
      jsonMap['value'] = value;
    }
    if (error != null) {
      jsonMap['error'] = error;
    }
    if (success != null) {
      jsonMap['success'] = success;
    }
    if (user != null) {
      jsonMap['user'] = user;
    }
    //print(jsonMap);
    return jsonMap;
  }

  Map<String, dynamic> logBody(
      {required message,
      required event,
      time,
      channel,
      identity,
      required Map<String, dynamic> meta,
      required bool isError,
      required String errorCode}) {
    Map<String, dynamic> jsonMap = {};
    jsonMap['message'] = message;
    jsonMap['event'] = event;
    if (time != null) {
      jsonMap['time'] = time;
    }
    jsonMap['channel'] = channel;
    jsonMap['meta'] = meta;
    jsonMap['isError'] = isError;
    jsonMap['errorCode'] = errorCode;

    return jsonMap;
  }

  Future<String?> getUserAgent() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? ua = sharedPreferences.getString(userAgent);
    if (ua == null) {
      await FkUserAgent.init();
      String ua = FkUserAgent.getProperty('packageUserAgent');
      String systemName = FkUserAgent.getProperty('systemName');
      String systemVersion = FkUserAgent.getProperty('systemVersion');
      if (!systemVersion.contains('.')) {
        String newSystemVersion = '$systemName $systemVersion.0';
        ua = ua.replaceFirst('$systemName $systemVersion', newSystemVersion);
      }

      await sharedPreferences.setString(userAgent, ua);
    }
    return ua;
  }

  Future<bool> sendAnalytics(
      {required String category,
      required String action,
      dynamic label,
      dynamic value}) async {
    setStatus(ViewStatus.Loading);
    Map<String, dynamic> jsonMap = prepareBody(
        category: category, action: action, label: label, value: value);

    String? ua = await getUserAgent();
    // await izsLogService.sendAnalytics(jsonMap, ua ?? '');
    return true;
  }

  Future<bool> sendAnalyticsErrorLogs({
    required String message,
    required String event,
    dynamic time,
    required String channel,
    required Map<String, dynamic> meta,
    dynamic identity,
    required bool isError,
    required String errorCode,
  }) async {
    setStatus(ViewStatus.Loading);
    DateTime now = DateTime.now();
    String formattedDateTime =
        "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";

    Map<String, dynamic> jsonMap = logBody(
        message: message,
        event: event,
        time: formattedDateTime,
        channel: channel,
        meta: meta,
        isError: isError,
        errorCode: errorCode);

    String? ua = await getUserAgent();
    // await izsLogService.sendErrorLogs(jsonMap, ua ?? '', identity);
    setStatus(ViewStatus.Error);
    return true;
  }
}
