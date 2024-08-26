import 'package:flutter/material.dart';
import 'package:izesan/screens/learning/games.dart';
import 'package:izesan/screens/learning/lessons.dart';
import 'package:izesan/screens/nav_pages/accent_coach.dart';
import 'package:izesan/screens/nav_pages/classrooms.dart';
import 'package:izesan/screens/nav_pages/teachers_classroom.dart';
import 'package:izesan/screens/nav_pages/favourites.dart';
import 'package:izesan/screens/nav_pages/games.dart';
import 'package:izesan/screens/nav_pages/learning_resources.dart';
import 'package:izesan/screens/nav_pages/student_classroom.dart';
import 'package:izesan/screens/nav_pages/syllabus.dart';
import 'package:izesan/screens/nav_pages/teachers_dashboard.dart';
import 'package:izesan/screens/nav_pages/video_courses.dart';
import 'package:izesan/screens/settings_page/class_term_configuration.dart';
import 'package:izesan/screens/splash_screen/splash_screen.dart';
import 'package:izesan/screens/welcome_page/welcome_page.dart';

import '../utils/route_name.dart';
import 'StudentWidget/accent_recording_screen.dart';
import 'login/login.dart';
import 'nav_pages/settings_screen.dart';
import 'nav_pages/dashboard_page.dart';
import 'nav_pages/student_dashboard.dart';
import 'welcome_screen/welcome_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.welcomePage:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case '/WelcomeScreen':
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case RouteName.login:
        return MaterialPageRoute(
            builder: (_) =>
                Login(name: ((settings.arguments)) as Map<String, dynamic>));
      case RouteName.settingsScreen:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case RouteName.classTermConfigScreen:
        return MaterialPageRoute(builder: (_) => const ClassTermConfigScreen());
      case RouteName.studentDashboard:
        return MaterialPageRoute(builder: (_) => const StudentDashboard());
      case RouteName.teachersDashboard:
        return MaterialPageRoute(builder: (_) => const TeachersDashboard());
      case RouteName.learningResources:
        return MaterialPageRoute(builder: (_) => const LearningResources());
      case RouteName.syllabus:
        return MaterialPageRoute(builder: (_) => const Syllabus());
      case RouteName.favourites:
        return MaterialPageRoute(builder: (_) => const Favourites());
      case RouteName.teacherClassRoom:
        return MaterialPageRoute(builder: (_) => const TeachersClassRoom());
      case RouteName.studentClassRoom:
        return MaterialPageRoute(builder: (_) => const StudentClassRoom());
      case RouteName.videoCourses:
        return MaterialPageRoute(builder: (_) => const VideoCourses());
      case RouteName.accentCoach:
        return MaterialPageRoute(builder: (_) => const AccentCoach());
      case RouteName.recordingScreen:
        return MaterialPageRoute(builder: (_) => const RecordingScreen());
      case RouteName.classRooms:
        return MaterialPageRoute(builder: (_) => const ClassRooms());
      case RouteName.lessonsScreen:
        return MaterialPageRoute(
            builder: (_) =>  LessonsScreen(
              options: ((settings.arguments)) as Map<String, dynamic>));
      case RouteName.games:
        return MaterialPageRoute(
            builder: (_) => GamesScreens(
                options: ((settings.arguments)) as Map<String, dynamic>));
      default:
        if ('user' == 'user') {
          return MaterialPageRoute(builder: (_) => const Dashboard());
        }
        return MaterialPageRoute(builder: (_) => const Dashboard());
    }
  }
}
