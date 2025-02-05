import 'package:flutter/material.dart';
import 'package:spend_smart/config/routes/routes.dart';
import 'package:spend_smart/features/auth/presentation/screens/forget_password.dart';
import 'package:spend_smart/features/auth/presentation/screens/login_screen.dart';
import 'package:spend_smart/features/auth/presentation/screens/signup_screen.dart';
import 'package:spend_smart/features/onboarding/presentation/screens/onboarding_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
