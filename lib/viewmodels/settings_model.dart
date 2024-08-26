import 'package:dio/dio.dart';
import 'package:izesan/viewmodels/izs_analytics.dart';

import '../locator.dart';
import '../services/settings_services.dart';
import '../utils/local_store.dart';
import 'base_model.dart';

class SettingsModel extends BaseViewModel {
  final SettingsServices _settingsServices = locator<SettingsServices>();
  final IzsAnalytics _izsAnalytics = locator<IzsAnalytics>();

  // String errorMessage;

  Future changePwd(String password, String newPassword) async {
    final value = await LocalStoreHelper.getMeDetails();
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      response = await _settingsServices.changePassword(password, newPassword);
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        value?.phone != null ? _izsAnalytics.sendAnalyticsErrorLogs(
            message: 'Change Password Successful',
            event: 'change_password',
            identity: value?.phone,
            meta: {'password': password, 'newPassword': ''},
            isError: false,
            errorCode: response.statusCode.toString(),
            channel: 'mobile') : null;
        setStatus(ViewStatus.Success);
        return true;
      }
    } on DioException catch (e) {
      setStatus(ViewStatus.Error);
      final response = e.response;
      if (response != null) {
        errorMessage = (e.response!.data['message']);
        value?.phone != null ? _izsAnalytics.sendAnalyticsErrorLogs(
            message: errorMessage!,
            event: 'change_password',
            identity: value?.phone,
            meta: {'password': password, 'newPassword': ''},
            isError: true,
            errorCode: response.statusCode.toString(),
            channel: 'mobile') : null;
        setError(e, 'Oops Something Went Wrong, Try Again');
        return false;
      }
      setError(e, 'Oops Something Went Wrong, Try Again');
      return false;
    } catch (e){
      rethrow;
    }
  }

  Future<dynamic> changeEmail(String email) async {
    final value = await LocalStoreHelper.getMeDetails();
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      response = await _settingsServices.changeEmail(email);
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        String message = response.data['message'];
        setStatus(ViewStatus.Success);
        value?.phone != null ? _izsAnalytics.sendAnalyticsErrorLogs(
            message: 'Change email successful',
            event: 'change_email',
            identity: value?.phone,
            meta: {'email': email},
            isError: false,
            errorCode: response.statusCode.toString(),
            channel: 'mobile') : null;
        return message;
      }
      setStatus(ViewStatus.Success);
    } on DioException catch (e) {
      setStatus(ViewStatus.Error);
      final response = e.response;
      if (response != null) {
        errorMessage = e.response!.data['message'];
        value?.phone != null ? _izsAnalytics.sendAnalyticsErrorLogs(
            message: errorMessage!,
            event: 'change_email',
            identity: value?.phone,
            meta: {'email': email},
            isError: true,
            errorCode: response.statusCode.toString(),
            channel: 'mobile') : null;
        return setError(e, 'Oops Something Went Wrong, Try Again');
      }
      return setError(e, 'Oops Something Went Wrong, Try Again');
    } catch (e) {
      rethrow;
    }
  }

  Future changeName(String name) async {
    final value = await LocalStoreHelper.getMeDetails();
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      response = await _settingsServices.changeName(name);
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        String message = response.data['message'];
        setStatus(ViewStatus.Success);
        value?.phone != null ? _izsAnalytics.sendAnalyticsErrorLogs(
            message: 'Change name successful',
            event: 'change_name',
            identity: value?.phone,
            meta: {'name': name},
            isError: false,
            errorCode: response.statusCode.toString(),
            channel: 'mobile') : null;
        return message;
      }
    } on DioException catch (e) {
      setStatus(ViewStatus.Error);
      final response = e.response;
      if (response != null) {
        errorMessage = e.response!.data['message'];
        value?.phone != null ? _izsAnalytics.sendAnalyticsErrorLogs(
            message: errorMessage!,
            event: 'change_name',
            identity: value?.phone,
            meta: {'name': name},
            isError: true,
            errorCode: response.statusCode.toString(),
            channel: 'mobile') : null;
        return setError(e, 'Oops Something Went Wrong, Try Again');
      }
      return setError(e, 'Oops Something Went Wrong, Try Again');
    } catch (e) {
      rethrow;
    }
  }
}
