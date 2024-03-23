abstract class MainState {}

class MainInitialState extends MainState {}

class MainLoadingState extends MainState {}

class MainSuccessState extends MainState {}

class MainFailureState extends MainState {
  String failure;

  MainFailureState(this.failure);
}

class MainChangeBottomNavBarState extends MainState {}