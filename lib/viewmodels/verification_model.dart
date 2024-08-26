import 'dart:convert';

import 'package:izesan/locator.dart';
// import 'package:izesan/model/verification_status.dart';
// import 'package:izesan/services/verification_services.dart';
import 'package:izesan/utils/local_store.dart';
import 'package:izesan/viewmodels/base_model.dart';
import 'package:dio/dio.dart';

import '../services/verification_services.dart';
import 'izs_analytics.dart';

class VerifyViewModel extends BaseViewModel {
  final VerificationService _verifyService = locator<VerificationService>();
  final IzsAnalytics _izsAnalytics = locator<IzsAnalytics>();

  // VerificationStatus? verificationStatus;

  // List<VerificationStatus> _verificationStatus = [];
  // List<VerificationStatus> get verificationStatus => _verificationStatus;
  // set verificationStatus(List<VerificationStatus> value) {
  //   _verificationStatus = value;
  //   notifyListeners();
  // }



  Future startSecureAccount(String phone) async {
    final value = await LocalStoreHelper.getMeDetails();
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      // response = await _verifyService.initSecureAccount(phone);
      // if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      //   String message = response.data['message'];
      //   setStatus(ViewStatus.Success);
      //   return message;
      // }
    } on DioException catch (e) {
      setStatus(ViewStatus.Error);
      final response = e.response;
      if (response != null) {
        errorMessage = e.response!.data['message'];
        value?.phone != null
            ? _izsAnalytics.sendAnalyticsErrorLogs(
                message: errorMessage!,
                event: 'secure_account',
                identity: value?.phone,
                meta: {'phone': phone},
                isError: true,
                errorCode: response.statusCode.toString(),
                channel: 'mobile')
            : null;
        return setError(e, 'Oops Something Went Wrong, Try Again');
      }
      return setError(e, 'Oops Something Went Wrong, Try Again');
    } catch (e) {
      rethrow;
    }
  }

  // verify user email address after initiating
  Future<dynamic> verifyEmail(String code, String email) async {
    final value = await LocalStoreHelper.getMeDetails();
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      // response = await _verifyService.verifyOTP(code, email);
      setStatus(ViewStatus.Success);
    } on DioException catch (e) {
      setStatus(ViewStatus.Error);
      final response = e.response;
      if (response != null) {
        errorMessage = e.response!.data['message'];
        value?.phone != null
            ? _izsAnalytics.sendAnalyticsErrorLogs(
                message: errorMessage!,
                event: 'verifyEmail',
                identity: value?.phone,
                isError: true,
                errorCode: response.statusCode.toString(),
                meta: {'code': code, 'email': email},
                channel: 'mobile')
            : null;
        return setError(e, 'Oops Something Went Wrong, Try Again');
      }
      return setError(e, 'Oops Something Went Wrong, Try Again');
    } catch (e) {
      rethrow;
    }
    return response;
  }

  // verify user phone address after initiating
  Future<dynamic> verifyPhone(String code, String phone) async {
    final value = await LocalStoreHelper.getMeDetails();
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      // response = await _verifyService.verifyOTP(code, phone);
      setStatus(ViewStatus.Success);
    } on DioException catch (e) {
      setStatus(ViewStatus.Error);
      final response = e.response;
      if (response != null) {
        errorMessage = e.response!.data['message'];
        value?.phone != null ? _izsAnalytics.sendAnalyticsErrorLogs(
            message: errorMessage!,
            event: 'verify_phone',
            identity: value?.phone,
            isError: true,
            errorCode: response.statusCode.toString(),
            meta: {'code': code, 'phone': phone},
            channel: 'mobile') : null;
        return setError(e, 'Oops Something Went Wrong, Try Again');
      }
      return setError(e, 'Oops Something Went Wrong, Try Again');
    } catch (e) {
      rethrow;
    }
    return response;
  }

  Future resetPassword(String password, String code) async {
    final value = await LocalStoreHelper.getMeDetails();
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      response = await _verifyService.requestPassword(password, code);
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        value?.phone != null ? _izsAnalytics.sendAnalyticsErrorLogs(
                message: 'Password reset successful',
                event: 'request_password',
                identity: value?.phone,
                meta: {'code': code, 'password': ''},
            isError: false,
            errorCode: response.statusCode.toString(),
                channel: 'mobile')
            : null;
        setStatus(ViewStatus.Success);
        return response.statusCode;
      }
    } on DioException catch (e) {
      setStatus(ViewStatus.Error);
      final response = e.response;
      if (response != null) {
        errorMessage = e.response!.data['message'];
        value?.phone != null
            ? _izsAnalytics.sendAnalyticsErrorLogs(
                message: errorMessage!,
                event: 'request_password',
                identity: value?.phone,
            isError: true,
            errorCode: response.statusCode.toString(),
                meta: {'code': code, 'password': ''},
                channel: 'mobile')
            : null;
        return setError(e, 'Oops Something Went Wrong, Try Again');
      }
      return setError(e, 'Oops Something Went Wrong, Try Again');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> putPhoneNumber(String code, String subject) async {
    final value = await LocalStoreHelper.getMeDetails();
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      // response = await _verifyService.updatePhoneNumber(code, subject);
      // if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      //   setStatus(ViewStatus.Success);
      //   final Map<String, dynamic> data = response.data['data'];
      //   verificationCodeModel = VerificationCodeModel.fromJson(data);
      //   notifyListeners();
      //   return response;
      // }
    } on DioException catch (e) {
      setStatus(ViewStatus.Error);
      final response = e.response;
      if (response != null) {
        errorMessage = e.response!.data['message'];
        value?.phone != null
            ? _izsAnalytics.sendAnalyticsErrorLogs(
                message: errorMessage!,
                event: 'put_phone_number',
                identity: value?.phone,
                meta: {'code': code, 'subject': subject},
            isError: true,
            errorCode: response.statusCode.toString(),
                channel: 'mobile')
            : null;
        return setError(e, 'Oops Something Went Wrong, Try Again');
      }
      return setError(e, 'Oops Something Went Wrong, Try Again');
    } catch (e) {
      rethrow;
    }
  }
}
