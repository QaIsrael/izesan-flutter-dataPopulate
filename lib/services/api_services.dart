// ignore_for_file: overridden_fields

import 'dart:async';

import 'package:izesan/services/auth_state.dart';
import 'package:izesan/utils/env_config.dart';
import 'package:izesan/utils/local_store.dart';
import 'package:dio/dio.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';

import '../locator.dart';
import '../viewmodels/base_model.dart';

class ApiService extends BaseViewModel {
  late Dio client;
  final AuthState _authStateCtrl = locator<AuthState>();

  @override
  String? errorMessage;

  final ViewStatus _status = ViewStatus.Success;

  @override
  ViewStatus get viewStatus => _status;

  ApiService() {
    client = Dio();
    client.options.baseUrl = EnvConfig.baseUrl;
    client.options.sendTimeout = EnvConfig.timeout;
    client.options.connectTimeout = EnvConfig.timeout;
    client.options.receiveTimeout = EnvConfig.receiveTimeout;
  }

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  void setToken(String authToken) {
    client.options.headers['Authorization'] = 'Bearer $authToken';
  }

  Future<void> clientSetup() async {
    // final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    // String latestVersion = remoteConfig.getString('app_version');
    String latestVersion = await getAppVersion();

    final String authToken = await LocalStoreHelper.getUserToken();
    if (authToken.isNotEmpty) {
      client.options.headers['Authorization'] = 'Bearer $authToken';
    }

    // Add the X-App-Version interceptor
    // final String appVersion = latestVersion;
    // client.interceptors.add(XAppVersionInterceptor(appVersion));
    //
    // String epoch = '1701964175';
    // client.interceptors.add(XApiVersionInterceptor(epoch));

    // client.interceptors.add(NetworkSpeedInterceptor());

    client.interceptors.add(
      PrettyDioLogger(
        responseBody: true,
        requestBody: true,
      ),
    );

    // client.interceptors.add(
    //   QueuedInterceptorsWrapper(onError: (
    //     DioException e,
    //     errorInterceptorHandler,
    //   ) async {
    //     // Sentry.captureException(e, stackTrace: e.stackTrace);
    //     if (e.type == DioExceptionType.connectionTimeout) {
    //       // Toast.showErrorNotification(
    //       //     'Error connecting, check your internet and try again.');
    //     }
    //     if (e.response?.statusCode == 401) {
    //       await LocalStoreHelper.removeUserToken();
    //       client.options.headers['Authorization'] = null;
    //       _authStateCtrl.logOut();
    //     }
    //     return errorInterceptorHandler.reject(e);
    //   }),
    // );
  }
}

