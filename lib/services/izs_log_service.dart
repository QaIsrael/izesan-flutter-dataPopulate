import 'dart:convert';

import 'package:dio/dio.dart';

import '../locator.dart';
import '../utils/local_store.dart';
import 'api_services.dart';

class IzsLogService {
  final Dio _apiClient;

  static final ApiService _apiService = locator<ApiService>();

  IzsLogService() : _apiClient = _apiService.client;

  Future<Response> verifyUser(String phone, String password) {
    return _apiClient
        .post('/login', data: {'phone': phone, 'password': password});
  }

  Future<Response>sendAnalytics(Map<String, dynamic> jsonMap, String ua) async {
    String url = '/log';
    // String bearerAuth = 'Bearer ${localStorageManager!.token}';
    return await _apiClient.post(
      url,
      data: json.encode(jsonMap),
      options: Options(headers: {
        // 'authorization': bearerAuth,
        'content-type': 'application/json',
        'User-Agent': ua
      }),
    );
  }

  /// Send Payment Analytics
  sendPaymentAnalytics(Map<String, dynamic> jsonMap, String ua) async {
    String url = '/pay/log';
    await _apiClient.post(
      url,
      data: json.encode(jsonMap),
      options: Options(headers: {
        // 'authorization': bearerAuth,
        'content-type': 'application/json',
        'User-Agent': ua
      }),
    );
  }

  /// Send Error Logs
  sendErrorLogs(Map<String, dynamic> jsonMap, String ua, String identity) async {

    String url = '/error-log/$identity';
    await _apiClient.get(
      url,
      data: json.encode(jsonMap),
      options: Options(headers: {
        // 'authorization': bearerAuth,
        'content-type': 'application/json',
        'User-Agent': ua
      }),
    );
  }
}
