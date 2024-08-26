import 'dart:convert';

import 'package:izesan/services/games_services.dart';
import 'package:izesan/utils/games_data/parts_of_body/hausa.dart';
import 'package:izesan/utils/games_data/parts_of_body/igbo.dart';
import 'package:izesan/utils/games_data/parts_of_body/yoruba.dart';
import 'package:izesan/viewmodels/izs_analytics.dart';
import 'package:izesan/viewmodels/base_model.dart';
import '../locator.dart';
import '../model/body_part_model.dart';
import '../services/api_services.dart';


class GamesViewModel extends BaseViewModel {
  final ApiService _apiService = locator<ApiService>();
  final GamesServices _gamesServices = locator<GamesServices>();
  final IzsAnalytics _izsAnalytics = locator<IzsAnalytics>();


  // Future<dynamic> _getGames(String langId) async {
  //   setStatus(ViewStatus.Loading);
  //   Response? response;
  //   try {
  //     response = await _gamesServices.getAllLanguageGames(langId);
  //     if (response.statusCode! >= 200 && response.statusCode! <= 300) {
  //       setStatus(ViewStatus.Success);
  //       final String token = response.data['token']['token'];
  //       _apiService.setToken(token);
  //
  //       // LocalStoreHelper sessionManager = LocalStoreHelper();
  //       // Map<String, dynamic> userData = response.data;
  //       // SchoolUser schoolUser = SchoolUser.fromJson(userData);
  //       // await sessionManager.saveUser('School', schoolUser);
  //       // notifyListeners();
  //       return response.data;
  //     }
  //   } on DioException catch (e) {
  //     setStatus(ViewStatus.Error);
  //     final response = e.response;
  //     if (response != null) {
  //       errorMessage = e.response!.data['message'];
  //       return setError(e, 'Oops Something Went Wrong, Try Again');
  //     }
  //     return setError(e, 'Oops Something Went Wrong, Try Again');
  //   } catch (e) {
  //     setStatus(ViewStatus.Error);
  //     rethrow;
  //   }
  // }

  Future<dynamic> getGamesByType(String langId, String topicId, String langName) async {
    setStatus(ViewStatus.Loading);
    // Response? response;
    try {
      // response = await _gamesServices.getGamesByTopic(langId, topicId);
      // if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        setStatus(ViewStatus.Success);

        if (langName.contains('Yoruba')) {
          final List<dynamic> data = yorubaData;
          // final List<dynamic> data = response.data['data'];
          final List<BodyPartModel> games = data.map((json) {
            return BodyPartModel.fromJson(json);
          }).toList();

          return games;
        }
        else if (langName.contains('Igbo')) {
          final List<dynamic> data = igboPodData;
          // final List<dynamic> data = response.data['data'];
          final List<BodyPartModel> games = data.map((json) {
            return BodyPartModel.fromJson(json);
          }).toList();

          return games;
        }
        else if (langName.contains('Hausa')) {
          final List<dynamic> data = hausaData;
          // final List<dynamic> data = response.data['data'];
          final List<BodyPartModel> games = data.map((json) {
            return BodyPartModel.fromJson(json);
          }).toList();

          return games;
        }

      // }
    } catch (e) {
      setStatus(ViewStatus.Error);
      rethrow;
    }
  }
}
