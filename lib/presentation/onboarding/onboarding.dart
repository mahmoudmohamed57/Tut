import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tut/app/app_prefs.dart';
import 'package:tut/app/di.dart';
import 'package:tut/domain/model/models.dart';
import 'package:tut/presentation/onboarding/cubit/cubit.dart';
import 'package:tut/presentation/onboarding/cubit/state.dart';
import 'package:tut/presentation/resources/assets_manager.dart';
import 'package:tut/presentation/resources/color_manager.dart';
import 'package:tut/presentation/resources/routes_manager.dart';
import 'package:tut/presentation/resources/strings_manager.dart';
import 'package:tut/presentation/resources/values_manager.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingInCubit, OnBoardingState>(
      builder: (context, state) {
        var cubit = OnBoardingInCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: AppSize.s0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
          body: PageView.builder(
            controller: cubit.pageController,
            itemCount: cubit.list.length,
            onPageChanged: (index) {
              cubit.onPageChanged(index);
            },
            itemBuilder: (context, index) => OnBoardingPage(cubit.list[index]),
          ),
          bottomSheet: Container(
            color: ColorManager.white,
            height: AppSize.s100,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      final AppPreferences appPreferences =
                          instance<AppPreferences>();
                      appPreferences.setOnBoardingScreenViewed();
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.loginRoute,
                      );
                    },
                    child: Text(
                      AppStrings.skip,
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.end,
                    ).tr(),
                  ),
                ),
                _getBottomSheetWidget(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getBottomSheetWidget(context) {
    var cubit = OnBoardingInCubit.get(context);
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
              onTap: () {
                cubit.pageController.animateToPage(
                  cubit.getPreviousIndex(),
                  duration: const Duration(milliseconds: DurationConstant.d300),
                  curve: Curves.bounceInOut,
                );
              },
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < cubit.list.length; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, cubit.currentIndex),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
              onTap: () {
                cubit.pageController.animateToPage(
                  cubit.getNextIndex(),
                  duration: const Duration(milliseconds: DurationConstant.d300),
                  curve: Curves.bounceInOut,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s4),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ).tr(),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ).tr(),
        ),
        const SizedBox(height: AppSize.s4),
        SvgPicture.asset(_sliderObject.image)
      ],
    );
  }
}
