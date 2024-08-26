import 'dart:async';
import 'dart:ui';

import 'package:izesan/model/bodypart_box_model.dart';
import 'package:izesan/model/lessons.dart';
import 'package:izesan/model/video_lessons.dart';
import 'package:izesan/screens/router.dart';
import 'package:izesan/services/api_services.dart';
import 'package:izesan/theme/app_theme.dart';
import 'package:izesan/utils/analytic_provider.dart';
import 'package:izesan/utils/encryption_helper.dart';
import 'package:izesan/utils/local_store.dart';
import 'package:izesan/utils/remote_config.dart';
import 'package:izesan/utils/route_name.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:izesan/viewmodels/auth_model.dart';
import 'package:izesan/viewmodels/games_view_model.dart';
import 'package:izesan/viewmodels/home_page_model.dart';
import 'package:izesan/viewmodels/izs_analytics.dart';
import 'package:izesan/viewmodels/leaning_view_model.dart';
import 'package:izesan/viewmodels/school_view_model.dart';
import 'package:izesan/viewmodels/settings_model.dart';
import 'package:izesan/viewmodels/students_view_model.dart';
import 'package:izesan/viewmodels/teachers_view_model.dart';
import 'package:izesan/viewmodels/verification_model.dart';
import 'package:provider/provider.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';

import 'locator.dart';
import 'model/language_box_model.dart';
import 'model/lesson_box_model.dart';
import 'model/languages.dart';
import 'model/video_lessons_box_model.dart';
// import 'model/notification_model.dart';
// import 'model/user_transaction_model.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void setStatusBarBrightness(BuildContext context) {
  ///TODO UPDATE DID CODE
  Brightness statusBarBrightness;

  // Determine theme mode
  if (Theme.of(context).brightness == Brightness.dark) {
    statusBarBrightness = Brightness.dark;
  } else {
    statusBarBrightness = Brightness.light;
  }

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: statusBarBrightness,
    ),
  );
}


void main() async {
  // String dsn = 'https://testc@o436025.ingest.sentry.io/000000';

  WidgetsFlutterBinding.ensureInitialized();
  //instantiation of the initializeEncryptionKey class
  // await EncryptionHelper.initializeEncryptionKey();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //
  // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);


  // for handling in terminated state
  // final RemoteMessage? message =
  // await FirebaseMessaging.instance.getInitialMessage();

  // if (message != null) {
  //   print("Launched from terminated state");
  //   Future.delayed(const Duration(seconds: 1), () {
  //
  //     navigatorKey.currentState!.pushNamed(RouteName.notification);
  //   });
  // }

  // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };

  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };

  await setupLocator();
  await LocalStoreHelper.getTheme();
  await _setupDioApiClient();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter<LanguageBoxModel>(LanguageBoxModelAdapter());
  Hive.registerAdapter<LessonBoxModel>(LessonBoxModelAdapter());
  Hive.registerAdapter<VideoLessonsBoxModelHive>(VideoLessonsBoxModelHiveAdapter());
  Hive.registerAdapter(QuestionOptionHiveAdapter());
  Hive.registerAdapter(QuestionsHiveAdapter());
  Hive.registerAdapter(TopicsHiveAdapter());

  Hive.registerAdapter<BodyPartBoxModel>(BodyPartBoxModelAdapter());
  // Hive.registerAdapter(TopicBodyPartAdapter());
  Hive.registerAdapter(OptionBodyPartAdapter());
  Hive.registerAdapter(LanguageBodyPartAdapter());

  // await Hive.openBox<LanguageBoxModel>('language_box');
  // await Hive.openBox<LessonBoxModel>('lessons_box');
  // await Hive.openBox<VideoLessonsBoxModelHive>('video_lessons_box');
  // await Hive.openBox<BodyPartBoxModel>('body_part_data');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
        ChangeNotifierProvider<AppTheme>(create: (_) => AppTheme()),
        ChangeNotifierProvider<IzsAnalytics>(create: (_) => IzsAnalytics()),
        ChangeNotifierProvider<HomePageModel>(create: (_) => HomePageModel()),
        ChangeNotifierProvider<SettingsModel>(create: (_) => SettingsModel()),

        ChangeNotifierProvider<LearningViewModel>(create: (_) => LearningViewModel()),
        ChangeNotifierProvider<StudentsViewModel>(create: (_) => StudentsViewModel()),
        ChangeNotifierProvider<TeachersViewModel>(create: (_) => TeachersViewModel()),
        ChangeNotifierProvider<SchoolViewModel>(create: (_) => SchoolViewModel()),
        ChangeNotifierProvider<GamesViewModel>(create: (_) => GamesViewModel()),
        ChangeNotifierProvider<VerifyViewModel>(create: (_) => VerifyViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> _setupDioApiClient() async {
  await locator<ApiService>().clientSetup();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  // RemoteConfigService remoteConfigService = RemoteConfigService();
  final GlobalKey<NavigatorState> navKey = GlobalKey();
  late StreamSubscription subscription;

  // bool initialToastShown = false;

  @override
  void initState() {
    super.initState();
    // remoteConfigService.initConfig();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppTheme>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Izesan',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      onGenerateRoute: Router.generateRoute,
      builder: (context, child) {
        return child!;
      },
    );
  }
}
