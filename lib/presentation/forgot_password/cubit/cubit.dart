import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/domain/usecase/forgot_password_usecase.dart';
import 'package:tut/presentation/forgot_password/cubit/state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordCubit(this._forgotPasswordUseCase)
      : super(ForgotPasswordInitialState());

  static ForgotPasswordCubit get(context) => BlocProvider.of(context);

  Future<void> forgotPassword({
    required String email,
  }) async {
    emit(ForgotPasswordLoadingState());
    (await _forgotPasswordUseCase.execute(email)).fold(
      (failure) => {
        emit(ForgotPasswordFailureState(failure.message)),
      },
      (data) => {
        emit(ForgotPasswordSuccessState(data)),
      },
    );
  }
}
