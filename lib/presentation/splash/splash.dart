import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tut/app/app_prefs.dart';
import 'package:tut/app/di.dart';
import 'package:tut/presentation/resources/assets_manager.dart';
import 'package:tut/presentation/resources/color_manager.dart';
import 'package:tut/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  _goNext() {
    _appPreferences.isUserLoggedIn().then(
          (isUserLoggedIn) => {
            if (isUserLoggedIn)
              {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.mainRoute,
                ),
              }
            else
              {
                _appPreferences.isOnBoardingScreenViewed().then(
                      (isOnBoardingScreenViewed) => {
                        if (isOnBoardingScreenViewed)
                          {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.loginRoute,
                            ),
                          }
                        else
                          {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.onBoardingRoute,
                            ),
                          }
                      },
                    ),
              }
          },
        );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(image: AssetImage(ImageAssets.splashLogo)),
      ),
    );
  }
}
