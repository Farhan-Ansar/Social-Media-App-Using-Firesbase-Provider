import 'package:flutter/material.dart';
import 'package:socialmedia_firebase/utils/routes/route_name.dart';
import 'package:socialmedia_firebase/view/dashboard/dashboard_screen.dart';
import 'package:socialmedia_firebase/view/forgetPassword/forget_password.dart';
import 'package:socialmedia_firebase/view/login/login_screen.dart';
import 'package:socialmedia_firebase/view/signup/sign_up_screen.dart';

import '../../view/splash/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.loginView:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteName.signUpView:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RouteName.dashboardView:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case RouteName.forgetPasswordView:
        return MaterialPageRoute(builder: (_) => const ForgetPassword());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
