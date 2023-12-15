import 'package:flutter/material.dart';

import '../../features/auth/pages/login_page.dart';
import '../../features/auth/pages/otp_page.dart';
import '../../features/onboarding/pages/onboarding.dart';
import '../../features/todo/pages/home_page.dart';

class Routes {
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String otp = 'otp';
  static const String home = 'home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (context) => const Onboarding());
      case login:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case otp:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => OtpPage(
            phone: args['phone'],
            smsCodeId: args['smsCodeId'],
          ),
        );
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      default:
        return MaterialPageRoute(builder: (context) => const LoginPage());
    }
  }
}
