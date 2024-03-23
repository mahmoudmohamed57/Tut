import 'dart:ffi';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/domain/usecase/details_usecase.dart';
import 'package:tut/presentation/details/cubit/state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final DetailsUseCase _detailsUseCase;

  DetailsCubit(this._detailsUseCase) : super(DetailsInitialState());

  static DetailsCubit get(context) => BlocProvider.of(context);

  Future<void> getDetailsData() async {
    emit(DetailsLoadingState());
    (await _detailsUseCase.execute(Void)).fold(
      (failure) => {
        emit(DetailsFailureState(failure.message)),
      },
      (data) => {
        emit(DetailsSuccessState(data)),
      },
    );
  }
}
