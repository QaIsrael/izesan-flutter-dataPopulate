import 'package:izesan/services/games_services.dart';
import 'package:izesan/services/izs_log_service.dart';
import 'package:izesan/services/error_state.dart';
import 'package:izesan/services/api_services.dart';
import 'package:izesan/services/auth_services.dart';
import 'package:izesan/services/auth_state.dart';
import 'package:izesan/services/home_page_services.dart';
import 'package:izesan/services/learning_services.dart';
import 'package:izesan/services/notification_services.dart';
import 'package:izesan/services/schools_services.dart';
import 'package:izesan/services/settings_services.dart';
import 'package:izesan/services/students_services.dart';
import 'package:izesan/services/teachers_services.dart';
import 'package:izesan/services/user_manager.dart';
import 'package:izesan/services/home_page_services.dart';
import 'package:izesan/services/verification_services.dart';
import 'package:izesan/utils/local_store.dart';
import 'package:izesan/viewmodels/izs_analytics.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setupLocator() async {
  // var remoteConfig = RemoteConfigService();
  // await remoteConfig.initConfig();
  // locator.registerSingleton(RemoteConfigService);
  locator.registerLazySingleton(() => AuthState());
  locator.registerLazySingleton(() => ErrorState());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => LearningServices());
  locator.registerLazySingleton(() => SchoolsServices());
  locator.registerLazySingleton(() => TeachersServices());
  locator.registerLazySingleton(() => StudentsServices());
  locator.registerLazySingleton(() => IzsLogService());
  locator.registerLazySingleton(() => IzsAnalytics());
  locator.registerLazySingleton(() => VerificationService());
  locator.registerLazySingleton(() => NotificationServices());
  locator.registerLazySingleton(() => HomePageServices());
  locator.registerLazySingleton(() => SettingsServices());
  locator.registerSingleton<ApiService>(ApiService());
  locator.registerSingleton<UserManager>(UserManager());
  locator.registerLazySingleton(() => GamesServices());
  locator.registerSingleton<LocalStoreHelper>(LocalStoreHelper());
}
