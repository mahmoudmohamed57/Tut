import 'package:dio/dio.dart';
import 'package:tut/data/network/failure.dart';
import 'package:tut/presentation/resources/strings_manager.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorised,
  notFound,
  internalServerError,
  connectionTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  unknown,
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.unknown.getFailure();
    }
  }

  Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectionTimeout.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure();
      case DioExceptionType.unknown:
        return DataSource.unknown.getFailure();
      case DioExceptionType.badCertificate:
        return DataSource.unknown.getFailure();
      case DioExceptionType.connectionError:
        return DataSource.cacheError.getFailure();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case ResponseCode.badRequest:
            return DataSource.badRequest.getFailure();
          case ResponseCode.forbidden:
            return DataSource.forbidden.getFailure();
          case ResponseCode.unAuthorised:
            return DataSource.unAuthorised.getFailure();
          case ResponseCode.notFound:
            return DataSource.notFound.getFailure();
          case ResponseCode.internalServerError:
            return DataSource.internalServerError.getFailure();
          default:
            return DataSource.unknown.getFailure();
        }
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unAuthorised:
        return Failure(ResponseCode.unAuthorised, ResponseMessage.unAuthorised);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(
          ResponseCode.internalServerError,
          ResponseMessage.internalServerError,
        );
      case DataSource.connectionTimeout:
        return Failure(
          ResponseCode.connectTimeout,
          ResponseMessage.connectTimeout,
        );
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.receiveTimeout:
        return Failure(
          ResponseCode.receiveTimeout,
          ResponseMessage.receiveTimeout,
        );
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(
          ResponseCode.noInternetConnection,
          ResponseMessage.noInternetConnection,
        );
      case DataSource.unknown:
        return Failure(ResponseCode.unknown, ResponseMessage.unknown);
      default:
        return Failure(ResponseCode.unknown, ResponseMessage.unknown);
    }
  }
}

class ResponseCode {
  // API status codes
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int forbidden = 403;
  static const int unAuthorised = 401;
  static const int notFound = 404;
  static const int internalServerError = 500;

  // local status code
  static const int unknown = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  // API status message
  static const String success = AppStrings.success;
  static const String noContent = AppStrings.success;
  static const String badRequest = AppStrings.badRequestError;
  static const String forbidden = AppStrings.unauthorizedError;
  static const String unAuthorised = AppStrings.forbiddenError;
  static const String notFound = AppStrings.internalServerError;
  static const String internalServerError = AppStrings.notFoundError;

  // local status message
  static const String unknown = AppStrings.timeoutError;
  static const String connectTimeout = AppStrings.defaultError;
  static const String cancel = AppStrings.timeoutError;
  static const String receiveTimeout = AppStrings.timeoutError;
  static const String sendTimeout = AppStrings.timeoutError;
  static const String cacheError = AppStrings.cacheError;
  static const String noInternetConnection = AppStrings.noInternetError;
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
