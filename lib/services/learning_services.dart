import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../locator.dart';
import '../utils/local_store.dart';
import 'api_services.dart';

class LearningServices {
  final Dio _apiClient;

  static final ApiService _apiServices = locator<ApiService>();

  LearningServices() : _apiClient = _apiServices.client;



  Future<Response> getMeDetails() {
    return _apiClient.get('/me');
  }
  Future<Response> getLanguages() {
    return _apiClient.get('/language',
      options: Options(
        contentType: Headers.jsonContentType, // Set content type to JSON
        sendTimeout: Duration.zero, // Set sendTimeout to 0 for GET requests
      ),
    );
  }

  Future<Response> getLessons() {
    return _apiClient.get('/type?type=standalone&language_id=3',
      options: Options(
        contentType: Headers.jsonContentType, // Set content type to JSON
        sendTimeout: Duration.zero, // Set sendTimeout to 0 for GET requests
      ),
    );
  }

  Future<Response> getVideos(String cls, int term, String langId) {
    return _apiClient.get('/type?type=sectional&class=$cls&term=$term&language_id=$langId',
      options: Options(
        contentType: Headers.jsonContentType, // Set content type to JSON
        sendTimeout: Duration.zero, // Set sendTimeout to 0 for GET requests
      ),
    );
  }

  Future<Response> downloadAndSaveImage(String url, String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filename');

    return _apiClient.download(url, file.path);
  }

  Future<Response> lessonGames() {
    return _apiClient.get('/language/lessons/games',
      options: Options(
        contentType: Headers.jsonContentType, // Set content type to JSON
        sendTimeout: Duration.zero, // Set sendTimeout to 0 for GET requests
      ),
    );
  }

  Future download(orderId) async {
    final String authToken = await LocalStoreHelper.getUserToken();

    if (authToken.isNotEmpty) {
      _apiClient.options.headers['Authorization'] = 'Bearer $authToken';

      return _apiClient.get('/orders/$orderId/receipt',
          options: Options(responseType: ResponseType.bytes));
    }
  }


}


