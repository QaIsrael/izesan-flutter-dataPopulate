import 'package:izesan/model/school_user.dart';
import 'package:izesan/model/teacher_user.dart';
import 'package:izesan/services/izs_log_service.dart';
import 'package:izesan/viewmodels/izs_analytics.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:dio/dio.dart';
import 'package:izesan/utils/local_store.dart';
import 'package:izesan/viewmodels/base_model.dart';
import '../locator.dart';
import '../model/student_user.dart';
import '../services/api_services.dart';
import '../services/auth_services.dart';
import '../utils/local_store.dart';
import 'base_model.dart';

class StudentsViewModel extends BaseViewModel {
  final ApiService _apiService = locator<ApiService>();
  final AuthService _authService = locator<AuthService>();
  final IzsAnalytics _izsAnalytics = locator<IzsAnalytics>();

  Future<dynamic> getSchool(String userName, String password) async {
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      response = await _authService.schoolLogin(userName, password);
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        setStatus(ViewStatus.Success);
        final String token = response.data['token']['token'];
        _apiService.setToken(token);

        await LocalStoreHelper.saveInfo(token);
        LocalStoreHelper sessionManager = LocalStoreHelper();
        Map<String, dynamic> userData = response.data;
        SchoolUser schoolUser = SchoolUser.fromJson(userData);
        await sessionManager.saveUser('School', schoolUser);
        notifyListeners();
        return response.data;
      }
    } on DioException catch (e) {
      setStatus(ViewStatus.Error);
      final response = e.response;
      if (response != null) {
        errorMessage = e.response!.data['message'];
        return setError(e, 'Oops Something Went Wrong, Try Again');
      }
      return setError(e, 'Oops Something Went Wrong, Try Again');
    } catch (e) {
      setStatus(ViewStatus.Error);
      rethrow;
    }
  }
}
