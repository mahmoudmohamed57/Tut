import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tut/app/app.dart';
import 'package:tut/app/di.dart';
import 'package:tut/presentation/resources/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    EasyLocalization(
      supportedLocales: const [arabicLocal, englishLocal],
      path: assetPathLocalisations,
      child: Phoenix(child: MyApp()),
    ),
  );
}
