import 'package:dio/dio.dart';

import '../locator.dart';
import 'api_services.dart';

class VerificationService {
  final Dio _apiClient;

  static final ApiService _apiService = locator<ApiService>();

  VerificationService() : _apiClient = _apiService.client;


  Future<Response> getEmailVerification(String email) {
    return _apiClient.get('/verifications?where={"identity":"$email"}');
  }

  Future<Response> getPhoneEmailVerification(String verify) {
    return _apiClient.get('/verifications?where={"identity":"$verify"}');
  }

  Future<Response> getMeCompliance() {
    return _apiClient.get('/me/.....');
  }

  Future<Response> requestPassword(String password, String code) {
    return _apiClient
        .put('/me/password?otpVerificationId=$code', data: {'password': password});
  }

}
