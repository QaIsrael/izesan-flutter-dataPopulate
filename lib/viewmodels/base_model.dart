import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:deep_pick/deep_pick.dart';

import '../locator.dart';
import '../services/error_state.dart';

enum ViewStatus { Loading, Success, Error }

class BaseViewModel extends ChangeNotifier {
  String? errorMessage;


  String? _customErrorMessage;
  String? get customErrorMessage => _customErrorMessage;

  ViewStatus _status = ViewStatus.Success;
  ViewStatus get viewStatus => _status;

  final ErrorState _internalServerError = locator<ErrorState>();

  void clearError() {
    errorMessage = null;
    _customErrorMessage = null;
  }

  void setError(e, String defaultMsg) {
    if (e is DioException) {
      final error = e.response?.data;
      final errors = e.response?.data['message'];
      if (error != null) {
          errorMessage = pick(error, 'message').asStringOrNull();
        if (error?.runtimeType == String) {
          errorMessage = pick(error, 'message').asStringOrNull();
        }
        if (errors?.runtimeType == String) {
          errorMessage = errors;
        }
      }
      else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'Connection error, Kindly check your network and try again';
      }
      else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timeout, please try again later';
      }
      else if (e.type == DioExceptionType.badResponse) {
        errorMessage = 'Something went wrong, please try again later';
      }
      else if (e.type == DioExceptionType.cancel) {
        errorMessage = 'Sorry! Request canceled';
      }
      else if (e.type == DioExceptionType.unknown) {
        errorMessage = 'Something went wrong, please try again later';
      }
      else if (e is SocketException) {
        errorMessage = 'Something went wrong, please try again later';
      }
    }

    errorMessage = errorMessage; //?? defaultMsg
    setStatus(ViewStatus.Error);

    //Add Error to StreamController
    _internalServerError.updateError();
  }

  void setStatus(ViewStatus status) {
    _status = status;
    notifyListeners();
  }

  void setCustomError(String? message) {
    _customErrorMessage = message;
    notifyListeners();
  }
}
