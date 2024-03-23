import 'package:tut/domain/model/models.dart';

abstract class DetailsState {}

class DetailsInitialState extends DetailsState {}

class DetailsLoadingState extends DetailsState {}

class DetailsSuccessState extends DetailsState {
  Details data;

  DetailsSuccessState(this.data);
}

class DetailsFailureState extends DetailsState {
  String failure;

  DetailsFailureState(this.failure);
}
