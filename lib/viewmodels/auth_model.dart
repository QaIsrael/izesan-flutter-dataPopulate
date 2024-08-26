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

//Callback function type to show user password alert
typedef ShowAlertCallback = void Function(String message);

class AuthViewModel extends BaseViewModel {
  final ApiService _apiService = locator<ApiService>();
  final AuthService _authService = locator<AuthService>();
  final IzsAnalytics _izsAnalytics = locator<IzsAnalytics>();

  // User? user;
  // void setResponse(response) {
    // _otpInitResponse = response;
    // _otpInitResponse = OtpInitResponseModel.fromJson(response);
    // notifyListeners();
  // }


  StudentUser? _student;
  StudentUser? get getStudentUser => _student;
  void setStudentUser(StudentUser value) {
    _student = value;
    notifyListeners();
  }


  Future<dynamic> login(String userName, String password) async {
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

  Future<dynamic> teacherLogin(String userName) async {
    LocalStoreHelper sessionManager = LocalStoreHelper();
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      response = await _authService.teachersLogin(userName);
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        setStatus(ViewStatus.Success);
        final String token = response.data['token']['token'];
        _apiService.setToken(token);

        await LocalStoreHelper.saveInfo(token);
        Map<String, dynamic> userData = response.data;
        TeacherUser teacherUser = TeacherUser.fromJson(userData);
        await sessionManager.saveUser('Teacher', teacherUser);
        notifyListeners();
        return response.data;
      }
    } on DioException catch (e) {
      setStatus(ViewStatus.Error);
      final response = e.response;
      if (response != null) {
        errorMessage = e.response!.data['message'];
        print(e);
         return setError(e, 'Oops Something Went Wrong, Try Again');
      }
      return setError(e, 'Oops Something Went Wrong, Try Again');
    } catch (e) {
      setStatus(ViewStatus.Error);
      print(e);

      rethrow;
    }
  }

  Future<dynamic> studentLogin(String userName) async {
    LocalStoreHelper sessionManager = LocalStoreHelper();
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      response = await _authService.studentLogin(userName);
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        setStatus(ViewStatus.Success);
        final String token = response.data['token']['token'];
        _apiService.setToken(token);
        await LocalStoreHelper.saveInfo(token);
        Map<String, dynamic> userData = response.data['data'];
        StudentUser studentUser = StudentUser.fromJson(userData);
        await sessionManager.saveUser('Student', studentUser);
        setStudentUser(studentUser);
        return response.data;
      }
    } on DioException catch (e) {
      setStatus(ViewStatus.Error);
      final response = e.response;
      if (response != null) {
        errorMessage = e.response!.data['message'];
        print(e);

        return setError(e, 'Oops Something Went Wrong, Try Again');
      }
      return setError(e, 'Oops Something Went Wrong, Try Again');
    } catch (e) {
      setStatus(ViewStatus.Error);
      print(e);
      rethrow;
    }
  }

  Future<dynamic> parentLogin(String userName) async {
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      response = await _authService.parentLogin(userName);
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        setStatus(ViewStatus.Success);
        final String token = response.data['token']['token'];

        _apiService.setToken(token);
        await LocalStoreHelper.saveInfo(token);
        notifyListeners();
        return response.data;

        // final Map<String, dynamic> data =
        //     pick(response.data, 'user').asMapOrEmpty();
        // user = User.fromJson(data);
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

  Future<dynamic> register(String phone) async {
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      // response = await _authService.checkUser(phone);
      // if (response.data['authToken'] != null) {
      //   final String token = response.data['authToken'];
      //   _apiService.setToken(token);
      //   await LocalStoreHelper.saveInfo(token);
      //   setStatus(ViewStatus.Success);
      // }
      setStatus(ViewStatus.Success);
    } on DioException catch (e) {
      setStatus(ViewStatus.Error);
      final response = e.response;
      if (response != null) {
        errorMessage = e.response!.data['message'];
        _izsAnalytics.sendAnalyticsErrorLogs(
            message: errorMessage!,
            event: 'sign_up',
            meta: {"phone": phone},
            isError: true,
            errorCode: response.statusCode.toString(),
            identity: phone,
            channel: 'mobile');
        return setError(e, 'Oops Something Went Wrong, Try Again');
      }
      return setError(e, 'Oops Something Went Wrong, Try Again');
    } catch (e) {
      setStatus(ViewStatus.Error);
      rethrow;
    }
  }
}