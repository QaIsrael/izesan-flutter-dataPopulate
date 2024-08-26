import 'package:dio/dio.dart';

import '../locator.dart';
import 'api_services.dart';

class SettingsServices {
  final Dio _apiClient;

  static final ApiService _apiService = locator<ApiService>();

  SettingsServices() : _apiClient = _apiService.client;

  Future<Response> changeEmail(String email) {
    return _apiClient.patch('/me', data: {'email': email});
  }

  Future<Response> changeName(String name) {
    return _apiClient.patch('/me', data: {'name': name});
  }

  Future<Response> changePassword(String oldPassword, String newPassword) {
    return _apiClient.put('/password', data: {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    });
  }

}
