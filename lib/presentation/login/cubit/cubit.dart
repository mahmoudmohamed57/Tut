import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/domain/usecase/login_usecase.dart';
import 'package:tut/presentation/login/cubit/state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    (await _loginUseCase.execute(LoginUseCaseInput(email, password))).fold(
      (failure) => {
        emit(LoginFailureState(failure.message)),
      },
      (data) => {
        emit(LoginSuccessState()),
      },
    );
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }
}
