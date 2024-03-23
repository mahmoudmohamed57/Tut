import 'package:dartz/dartz.dart';
import 'package:tut/data/network/failure.dart';
import 'package:tut/domain/model/models.dart';
import 'package:tut/domain/repository/repository.dart';
import 'package:tut/domain/usecase/base_usecase.dart';

class DetailsUseCase extends BaseUseCase<void, Details> {
  Repository repository;

  DetailsUseCase(this.repository);

  @override
  Future<Either<Failure, Details>> execute(void input) {
    return repository.getDetails();
  }
}
