import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsProvider with ChangeNotifier {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> logEvent(String name) async {
    await _analytics.logEvent(name: name);
  }

  Future<void> logAnalyticsEvent({required name,
    Map<String, dynamic>? parameters}) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  Future<void> logLoginEvent() async => await _analytics.logLogin();

  Future<void> logShareEvent({required String contentType,
    required String itemId}) async => _analytics.logShare(
      contentType: contentType, itemId: itemId, method: " share");

  Future<void> logSignUpEvent({required signUpMethod}) async =>
      await _analytics.logSignUp(signUpMethod: signUpMethod);

  Future<void> setUserId(String id) => _analytics.setUserId(id:id);

  Future<void> setUserProperties({required Map<String, String> parameters})
  async{
    if(parameters.isNotEmpty) {
      parameters.forEach((name,value){
        _analytics.setUserProperty(name: name, value: value).then((result){});
      });
    }
  }

  // Future<void> logButtonAnalytics({required text, state = btnEnabled,
  //   bool validationFailed = true}) async{
  //   var eventParam = <String, dynamic>{};
  //   eventParam[btnName] = text;
  //   eventParam[btnState] = state;
  //   if(state == btnEnabled) {
  //     eventParam[formValidationFailed] = validationFailed.toString();
  //   }
  //
  //   logAnalyticsEvent(name: btnClicked, parameters: eventParam);
  // }

  Future<void> logPayment({required num amount,
    required orderId, required String location}) async =>
      _analytics.logPurchase(
          currency: 'NGN',
          value: amount.toDouble(),
          transactionId: orderId);

  Future<void> logBeginPayment({required num amount,
    required orderId}) async => _analytics.logBeginCheckout(
      currency: 'NGN',
      value: amount.toDouble()
  );
}
