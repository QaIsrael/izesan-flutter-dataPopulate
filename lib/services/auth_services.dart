import 'package:dio/dio.dart';

import '../locator.dart';
import 'api_services.dart';

class AuthService {
  final Dio _apiClient;

  static final ApiService _apiService = locator<ApiService>();

  AuthService() : _apiClient = _apiService.client;

  Future<Response> schoolLogin(String userName, String password) {
    return _apiClient
        .post('/auth/schoolLogin', data: {'email': userName, 'password': password});
  }
  Future<Response> teachersLogin(String userName) {
    return _apiClient
        .post('/auth/teacherLogin',
        data: {'teacher_id': userName, 'password': '\$12345678\$'});
  }
  Future<Response> studentLogin(String userName) {
    return _apiClient
        .post('/auth/studentLogin',
        data: {'login_id': userName, 'password': "12345678"});
  }
  Future<Response> parentLogin(String userName) {
    return _apiClient
        .post('/auth/studentLogin',
        data: {'login_id': userName, 'password': "12345678"});
  }

  // Future<Response> resetPassword(String phone, transport) {
  //   return _apiClient.post('/verifications',
  //       data: {'transport': transport,'type': 'password','identity': phone});
  // }

}
