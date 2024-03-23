import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tut/app/app_prefs.dart';
import 'package:tut/app/constant.dart';

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "authorization";
const String defaultLanguage = "language";

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    String language = await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: Constant.token,
      defaultLanguage: language,
    };
    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: const Duration(seconds: Constant.timeOut),
      receiveTimeout: const Duration(seconds: Constant.timeOut),
      headers: headers,
    );
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
    return dio;
  }
}
