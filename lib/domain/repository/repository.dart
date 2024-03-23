import 'package:dartz/dartz.dart';
import 'package:tut/data/network/failure.dart';
import 'package:tut/data/network/requests.dart';
import 'package:tut/domain/model/models.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);

  Future<Either<Failure, String>> forgotPassword(String email);

  Future<Either<Failure, Authentication>> register(
    RegisterRequest registerRequest,
  );

  Future<Either<Failure, HomeObject>> getHomeData();

  Future<Either<Failure, Details>> getDetails();
}
