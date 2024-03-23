abstract class ForgotPasswordState {}

class ForgotPasswordInitialState extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}

class ForgotPasswordSuccessState extends ForgotPasswordState {
  String password;

  ForgotPasswordSuccessState(this.password);
}

class ForgotPasswordFailureState extends ForgotPasswordState {
  String failure;

  ForgotPasswordFailureState(this.failure);
}
