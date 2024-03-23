import 'package:dartz/dartz.dart';
import 'package:tut/data/network/failure.dart';
import 'package:tut/domain/repository/repository.dart';
import 'package:tut/domain/usecase/base_usecase.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, String> {
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String input) async {
    return await _repository.forgotPassword(input);
  }
}
