import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/domain/usecase/register_usecase.dart';
import 'package:tut/presentation/register/cubit/state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  Future<void> register({
    required String userName,
    required String countryMobileCode,
    required String mobileNumber,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    (await _registerUseCase.execute(
      RegisterUseCaseInput(
        userName,
        countryMobileCode,
        mobileNumber,
        email,
        password,
      ),
    ))
        .fold(
      (failure) => {
        emit(RegisterFailureState(failure.message)),
      },
      (data) => {
        emit(RegisterSuccessState()),
      },
    );
  }

  String countryMobileCode = '+20';

  void setCountryCode(String countryCode) {
    countryMobileCode = countryCode;
    emit(RegisterChangeCountryCodeState());
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
}
