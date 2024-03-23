import 'package:tut/domain/model/models.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  HomeObject data;
  HomeSuccessState(this.data);
}

class HomeFailureState extends HomeState {
  String failure;

  HomeFailureState(this.failure);
}
