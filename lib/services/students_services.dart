import 'package:dio/dio.dart';

import '../locator.dart';
import '../utils/local_store.dart';
import 'api_services.dart';

class StudentsServices {
  final Dio _apiClient;

  static final ApiService _apiServices = locator<ApiService>();

  StudentsServices() : _apiClient = _apiServices.client;



  Future<Response> getMeDetails() {
    return _apiClient.get('/me');
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
