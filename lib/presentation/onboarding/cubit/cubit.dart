import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/domain/model/models.dart';
import 'package:tut/presentation/onboarding/cubit/state.dart';
import 'package:tut/presentation/resources/assets_manager.dart';
import 'package:tut/presentation/resources/strings_manager.dart';

class OnBoardingInCubit extends Cubit<OnBoardingState> {
  OnBoardingInCubit() : super(OnBoardingInitialState());

  static OnBoardingInCubit get(context) => BlocProvider.of(context);

  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  List<SliderObject> list = [
    SliderObject(
      AppStrings.onBoardingTitle1,
      AppStrings.onBoardingSubTitle1,
      ImageAssets.onboardingLogo1,
    ),
    SliderObject(
      AppStrings.onBoardingTitle2,
      AppStrings.onBoardingSubTitle2,
      ImageAssets.onboardingLogo2,
    ),
    SliderObject(
      AppStrings.onBoardingTitle3,
      AppStrings.onBoardingSubTitle3,
      ImageAssets.onboardingLogo3,
    ),
    SliderObject(
      AppStrings.onBoardingTitle4,
      AppStrings.onBoardingSubTitle4,
      ImageAssets.onboardingLogo4,
    )
  ];

  int getNextIndex() {
    int nextIndex = currentIndex++;
    if (nextIndex >= list.length) {
      currentIndex = 0;
    }
    return currentIndex;
  }

  int getPreviousIndex() {
    int previousIndex = currentIndex--;
    if (previousIndex == -1) {
      currentIndex = list.length - 1;
    }
    return currentIndex;
  }

  void onPageChanged(int index) {
    currentIndex = index;
    emit(OnBoardingOnPageChangedState());
  }
}
