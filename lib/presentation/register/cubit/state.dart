abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterFailureState extends RegisterState {
  String failure;

  RegisterFailureState(this.failure);
}

class RegisterChangeCountryCodeState extends RegisterState {}

class RegisterChangePasswordVisibilityState extends RegisterState {}
