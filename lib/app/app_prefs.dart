import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut/presentation/resources/language_manager.dart';

const String prefsKeyLang = "prefsKeyLang";
const String prefsKeyOnBoardingScreenViewed = "prefsKeyOnBoardingScreenViewed";
const String prefsKeyIsUserLoggedIn = "prefsKeyIsUserLoggedIn";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }

  Future<void> changeAppLanguage() async {
    String currentLang = await getAppLanguage();

    if (currentLang == LanguageType.arabic.getValue()) {
      // set english
      _sharedPreferences.setString(
        prefsKeyLang,
        LanguageType.english.getValue(),
      );
    } else {
      // set arabic
      _sharedPreferences.setString(
        prefsKeyLang,
        LanguageType.arabic.getValue(),
      );
    }
  }

  Future<Locale> getLocal() async {
    String currentLang = await getAppLanguage();

    if (currentLang == LanguageType.arabic.getValue()) {
      return arabicLocal;
    } else {
      return englishLocal;
    }
  }

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(prefsKeyOnBoardingScreenViewed, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(prefsKeyOnBoardingScreenViewed) ?? false;
  }

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(prefsKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(prefsKeyIsUserLoggedIn) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(prefsKeyIsUserLoggedIn);
  }
}
