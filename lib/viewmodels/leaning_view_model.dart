import 'dart:io';

import 'package:izesan/model/lessons.dart';
import 'package:izesan/services/learning_services.dart';
import 'package:izesan/viewmodels/izs_analytics.dart';
import 'package:dio/dio.dart';
import 'package:izesan/viewmodels/base_model.dart';
import 'package:path_provider/path_provider.dart';
import '../locator.dart';
import '../model/languages.dart';
import '../model/parent_user.dart';
import '../model/school_user.dart';
import '../model/student_user.dart';
import '../model/teacher_user.dart';
import '../model/video_lessons.dart';
import '../services/api_services.dart';
import '../utils/local_store.dart';

class LearningViewModel extends BaseViewModel {
  final ApiService _apiService = locator<ApiService>();
  final LearningServices _learningServices = locator<LearningServices>();
  final IzsAnalytics _izsAnalytics = locator<IzsAnalytics>();

  late List<Language> languages = [];
  List<Language> get language => languages;
  void setLanguages(List<Language> lang) {
    languages = lang;
    notifyListeners();
  }

  late List<Lessons> lessons = [];
  List<Lessons> get getLessons => lessons;
  void setLessons(List<Lessons> value) {
    lessons = value;
    notifyListeners();
  }

  late List<VideoLessons> _videos = [];
  List<VideoLessons> get getVideoLessons => _videos;
  void setVideoLessons(List<VideoLessons> value) {
    _videos = value;
    notifyListeners();
  }

  Future<dynamic> getLanguages() async {
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      response = await _learningServices.getLanguages();
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        setStatus(ViewStatus.Success);
        List<dynamic> lang = response.data['data'];


        List<Languages> language = List<Languages>.from(
          lang.map((item) => Languages.fromJson(item)),
        );
        setLanguages(languages);
        return language;

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

  Future<dynamic> getLanguageLessons() async {
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      response = await _learningServices.getLessons();
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        setStatus(ViewStatus.Success);
        List<dynamic> lang = response.data['data'];
        List<Lessons> lesson = List<Lessons>.from(
          lang.map((item) => Lessons.fromJson(item)),
        );
        setLessons(lesson);
        return lesson;
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

  configureAppBasedOnUser(Map<String, dynamic> sessionData) {
    String userType = sessionData['userType'];
    Map<String, dynamic> userData = sessionData['userData'];

    switch (userType) {
      case 'School':
        SchoolUser schoolUser = SchoolUser.fromJson(userData);
        // Apply school-specific settings
        // userManager.setUser(schoolUser);
        break;
      case 'Teacher':
        TeacherUser teacherUser = TeacherUser.fromJson(userData);
        // Apply teacher-specific settings
        teacherUser;
        break;
      case 'Student':
        StudentUser studentUser = StudentUser.fromJson(userData);
        // Apply student-specific settings
        studentUser;
        break;
      case 'Parent':
        ParentUser parentUser = ParentUser.fromJson(userData);
        parentUser;        // Apply parent-specific settings;
        break;
      default:
        break;
    }
  }

  Future<dynamic> getVideos() async {
    LocalStoreHelper sessionManager = LocalStoreHelper();
    final sessionData = await sessionManager.getUser();
    if (sessionData != null && sessionData['userType'] == 'Student') {
      return getStudentVideo(sessionData);
    }
    else if (sessionData != null && sessionData['userType'] == 'Teacher') {
      return getTeachersVideo(sessionData);
    }

  }

  Future getStudentVideo(sessionData) async{
    try {
      Response? response;

      final studentData = sessionData!['userData'];
      String cls = studentData['class'];
      int term = studentData['school']['term'];
      String languageId = studentData['classLanguage'];
      setStatus(ViewStatus.Loading);
      response = await _learningServices.getVideos(cls, term,languageId);
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        setStatus(ViewStatus.Success);
        List<dynamic> videoResponse = response.data['data'];
        _videos = List<VideoLessons>.from(
          videoResponse.map((item) => VideoLessons.fromJson(item)),
        );

        setVideoLessons(_videos);
        return _videos;
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

  Future getTeachersVideo(sessionData) async{
    try {
      Response? response;

      final studentData = sessionData!['userData'];
      String cls = studentData['class'];
      int term = studentData['school']['term'];
      String languageId = studentData['classLanguage'];
      setStatus(ViewStatus.Loading);
      response = await _learningServices.getVideos(cls, term,languageId);
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        setStatus(ViewStatus.Success);
        List<dynamic> videoResponse = response.data['data'];
        _videos  = List<VideoLessons>.from(
          videoResponse.map((item) => VideoLessons.fromJson(item)),
        );
        setVideoLessons(_videos);
        return _videos;
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

  Future<dynamic> getGames() async {
    setStatus(ViewStatus.Loading);
    Response? response;
    try {
      response = await _learningServices.lessonGames();
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        setStatus(ViewStatus.Success);
        List<dynamic> lang = response.data['data'];
        List<Lessons> lesson = List<Lessons>.from(
          lang.map((item) => Language.fromJson(item)),
        );
        setLessons(lesson);
        return lesson;

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


    Future<dynamic> downloadAndSaveImage(String url, String filename) async {
    try{
    Response? response;
    final dio = Dio();
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filename');
    response = await dio.download(url, file.path);
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        return file.path;
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