import 'package:dartz/dartz.dart';
import 'package:tut/data/network/failure.dart';
import 'package:tut/domain/model/models.dart';
import 'package:tut/domain/repository/repository.dart';
import 'package:tut/domain/usecase/base_usecase.dart';

class HomeUseCase implements BaseUseCase<void, HomeObject> {
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHomeData();
  }
}
