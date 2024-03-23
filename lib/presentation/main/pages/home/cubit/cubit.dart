import 'dart:ffi';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/domain/usecase/home_usecase.dart';
import 'package:tut/presentation/main/pages/home/cubit/state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUseCase _homeUseCase;

  HomeCubit(this._homeUseCase) : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);


  Future<void> getHomeData() async {
    emit(HomeLoadingState());
    (await _homeUseCase.execute(Void)).fold(
      (failure) => {
        emit(HomeFailureState(failure.message)),
      },
      (data) => {
        emit(HomeSuccessState(data)),
      },
    );
  }
}
