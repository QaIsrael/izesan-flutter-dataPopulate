import 'package:dio/dio.dart';
import 'package:izesan/screens/nav_pages/games.dart';

import '../locator.dart';
import 'api_services.dart';

class GamesServices {
  final Dio _apiClient;

  static final ApiService _apiService = locator<ApiService>();

  GamesServices() : _apiClient = _apiService.client;

  Future<Response> getGamesByTopic(String langId, String topicId) {
    return _apiClient.get('/question?language_id=$langId&topic_id=$topicId');
  }

  Future<Response> getAllLanguageGames(String email) {
    return _apiClient.get('/question?language_id=1');
  }
}
