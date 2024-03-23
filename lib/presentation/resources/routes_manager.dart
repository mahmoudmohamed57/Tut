import 'package:flutter/material.dart';
import 'package:tut/app/di.dart';
import 'package:tut/presentation/details/details.dart';
import 'package:tut/presentation/forgot_password/forgot_password.dart';
import 'package:tut/presentation/login/login.dart';
import 'package:tut/presentation/main/main.dart';
import 'package:tut/presentation/onboarding/onboarding.dart';
import 'package:tut/presentation/register/register.dart';
import 'package:tut/presentation/resources/strings_manager.dart';
import 'package:tut/presentation/splash/splash.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String detailsRoute = "/details";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.detailsRoute:
        initDetailsModule();
        return MaterialPageRoute(builder: (_) => const DetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text(AppStrings.noRouteFound)),
        body: const Center(child: Text(AppStrings.noRouteFound)),
      ),
    );
  }
}
