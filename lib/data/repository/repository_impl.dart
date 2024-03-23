import 'package:dartz/dartz.dart';
import 'package:tut/data/data_source/local_data_source.dart';
import 'package:tut/data/data_source/remote_data_source.dart';
import 'package:tut/data/mapper/mapper.dart';
import 'package:tut/data/network/error_handler.dart';
import 'package:tut/data/network/failure.dart';
import 'package:tut/data/network/network_info.dart';
import 'package:tut/data/network/requests.dart';
import 'package:tut/domain/model/models.dart';
import 'package:tut/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
    this._localDataSource,
  );

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              response.status ?? ApiInternalStatus.failure,
              response.message ?? ResponseMessage.unknown,
            ),
          );
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgotPassword(email);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              response.status ?? ApiInternalStatus.failure,
              response.message ?? ResponseMessage.unknown,
            ),
          );
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              response.status ?? ApiInternalStatus.failure,
              response.message ?? ResponseMessage.unknown,
            ),
          );
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async {
    try {
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getHomeData();
          if (response.status == ApiInternalStatus.success) {
            _localDataSource.saveHomeToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(
              Failure(
                response.status ?? ApiInternalStatus.failure,
                response.message ?? ResponseMessage.unknown,
              ),
            );
          }
        } catch (error) {
          return (Left(ErrorHandler.handle(error).failure));
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Details>> getDetails() async {
    try {
      final response = await _localDataSource.getDetails();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getDetails();
          if (response.status == ApiInternalStatus.success) {
            _localDataSource.saveDetailsToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(
              Failure(
                response.status ?? ApiInternalStatus.failure,
                response.message ?? ResponseMessage.unknown,
              ),
            );
          }
        } catch (error) {
          return (Left(ErrorHandler.handle(error).failure));
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }
}
