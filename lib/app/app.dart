import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/app/app_prefs.dart';
import 'package:tut/app/di.dart';
import 'package:tut/presentation/details/cubit/cubit.dart';
import 'package:tut/presentation/forgot_password/cubit/cubit.dart';
import 'package:tut/presentation/login/cubit/cubit.dart';
import 'package:tut/presentation/main/cubit/cubit.dart';
import 'package:tut/presentation/main/pages/home/cubit/cubit.dart';
import 'package:tut/presentation/onboarding/cubit/cubit.dart';
import 'package:tut/presentation/register/cubit/cubit.dart';
import 'package:tut/presentation/resources/routes_manager.dart';
import 'package:tut/presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnBoardingInCubit()),
        BlocProvider(create: (context) => LoginCubit(instance())),
        BlocProvider(create: (context) => RegisterCubit(instance())),
        BlocProvider(create: (context) => ForgotPasswordCubit(instance())),
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => HomeCubit(instance())..getHomeData()),
        BlocProvider(
          create: (context) => DetailsCubit(instance())..getDetailsData(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        theme: getApplicationTheme(),
      ),
    );
  }
}
