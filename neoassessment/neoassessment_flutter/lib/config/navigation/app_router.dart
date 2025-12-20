import 'package:flutter/cupertino.dart';
import 'package:neoassessment_flutter/config/navigation/route_paths.dart';
import 'package:neoassessment_flutter/presentation/pages/changepassword.dart';
import 'package:neoassessment_flutter/presentation/pages/dashboard.dart';
//import 'package:neoassessment_flutter/presentation/pages/category.dart';
import 'package:neoassessment_flutter/presentation/pages/domain/domain_screen.dart';
import 'package:neoassessment_flutter/presentation/pages/exam/create_exam_screen.dart';
import 'package:neoassessment_flutter/presentation/pages/level/level_screen.dart';
import 'package:neoassessment_flutter/presentation/pages/question/question.dart';
import 'package:neoassessment_flutter/presentation/pages/questionCat/questionCat_screen.dart';
import 'package:neoassessment_flutter/presentation/pages/users/users.dart';

//import 'package:neoassessment_flutter/presentation/pages/question.dart';
//import 'package:neoassessment_flutter/presentation/pages/users.dart';

import '../../presentation/pages/base_screen.dart';
import '../../presentation/pages/loginscreen.dart';
import '../../presentation/pages/role/roles.dart';
import '../../presentation/pages/splashscreen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.splashscreen:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
          settings: const RouteSettings(name: RoutePaths.splashscreen),
        );
      case RoutePaths.baseScreen:
        return CupertinoPageRoute(
          builder: (context) => BaseScreen(),
          settings: const RouteSettings(name: RoutePaths.baseScreen),
        );
      case RoutePaths.user:
        return CupertinoPageRoute(
          builder: (context) => const UserScreen(),
          settings: const RouteSettings(name: RoutePaths.user),
        );
      case RoutePaths.domains:
        return CupertinoPageRoute(
          builder: (context) => const DomainScreen(),
          settings: const RouteSettings(name: RoutePaths.domains),
        );
      case RoutePaths.question:
        return CupertinoPageRoute(
          builder: (context) => const QuestionScreen(),
          settings: const RouteSettings(name: RoutePaths.question),
        );

      case RoutePaths.login:
        return CupertinoPageRoute(
          builder: (context) => const LoginPage(),
          settings: const RouteSettings(name: RoutePaths.login),
        );
      case RoutePaths.roles:
        return CupertinoPageRoute(
          builder: (context) => const RolesScreen(),
          settings: const RouteSettings(name: RoutePaths.roles),
        );
      case RoutePaths.level:
        return CupertinoPageRoute(
          builder: (context) => const LevelScreen(),
          settings: const RouteSettings(name: RoutePaths.level),
        );

      case RoutePaths.questionCategory:
        return CupertinoPageRoute(
            builder: (context) => const QuestionCategoryScreen(),
            settings: const RouteSettings(name: RoutePaths.questionCategory));
      // case RoutePaths.exam:
      //   return CupertinoPageRoute(
      //       builder: (context) => const ExamScreen(),
      //       settings: const RouteSettings(name: RoutePaths.exam));
      case RoutePaths.createExam:
        return CupertinoPageRoute(
            builder: (context) => const CreateExamScreen(),
            settings: const RouteSettings(name: RoutePaths.createExam));
      case RoutePaths.changePassword:
        return CupertinoPageRoute(
            builder: (context) => const ChangePasswordScreen(),
            settings: const RouteSettings(name: RoutePaths.changePassword));
      case RoutePaths.dashboard:
        return CupertinoPageRoute(
            builder: (context) => DashboardScreen(),
            settings: const RouteSettings(name: RoutePaths.dashboard));

      default:
        return CupertinoPageRoute(
          builder: (context) => Container(),
        );
    }
  }
}
