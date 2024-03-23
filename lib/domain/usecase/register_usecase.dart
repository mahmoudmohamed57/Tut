import 'package:dartz/dartz.dart';
import 'package:tut/data/network/failure.dart';
import 'package:tut/data/network/requests.dart';
import 'package:tut/domain/model/models.dart';
import 'package:tut/domain/repository/repository.dart';
import 'package:tut/domain/usecase/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(
      RegisterRequest(
        input.userName,
        input.countryMobileCode,
        input.mobileNumber,
        input.email,
        input.password,
      ),
    );
  }
}

class RegisterUseCaseInput {
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;

  RegisterUseCaseInput(
    this.userName,
    this.countryMobileCode,
    this.mobileNumber,
    this.email,
    this.password,
  );
}
