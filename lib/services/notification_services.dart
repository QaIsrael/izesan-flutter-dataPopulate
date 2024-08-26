import 'package:dio/dio.dart';

import '../locator.dart';
import 'api_services.dart';

class NotificationServices {
  final Dio _apiClient;

  static final ApiService _apiService = locator<ApiService>();

  NotificationServices() : _apiClient = _apiService.client;

  Future<Response> getNotification(int page) {
    var limit = 30;
    return _apiClient.get('/me/notifications',
      queryParameters: {
      'limit': limit,
      'page': page});
  }


  Future<Response> notificationSeen() {
    return _apiClient.get('/notification/seen');
  }

  Future<Response> deleteNotification(int id) {
    return _apiClient.delete('/me/notifications/$id');
  }
}
