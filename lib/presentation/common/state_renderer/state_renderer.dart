import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tut/presentation/resources/assets_manager.dart';
import 'package:tut/presentation/resources/color_manager.dart';
import 'package:tut/presentation/resources/font_manager.dart';
import 'package:tut/presentation/resources/strings_manager.dart';
import 'package:tut/presentation/resources/styles_manager.dart';
import 'package:tut/presentation/resources/values_manager.dart';

enum StateRendererType {
  popupLoadingState,
  popupErrorState,
  popupSuccess,
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  contentState
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function retryActionFunction;

  const StateRenderer({
    super.key,
    required this.stateRendererType,
    this.message = AppStrings.loading,
    this.title = "",
    required this.retryActionFunction,
  });

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopUpDialog(
          context,
          [_getAnimatedImage(JsonAssets.loading)],
        );
      case StateRendererType.popupErrorState:
        return _getPopUpDialog(
          context,
          [
            _getAnimatedImage(JsonAssets.error),
            _getMessage(message),
            _getRetryButton(AppStrings.ok, context),
          ],
        );
      case StateRendererType.popupSuccess:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.success),
          _getMessage(title),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context)
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn(
          [
            _getAnimatedImage(JsonAssets.loading),
            _getMessage(message),
          ],
        );
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn(
          [
            _getAnimatedImage(JsonAssets.error),
            _getMessage(message),
            _getRetryButton(AppStrings.retryAgain, context),
          ],
        );
      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn(
          [
            _getAnimatedImage(JsonAssets.empty),
            _getMessage(message),
          ],
        );
      case StateRendererType.contentState:
        return Container();
      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [BoxShadow(color: Colors.black26)],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          style: getRegularStyle(
            color: ColorManager.black,
            fontSize: FontSize.s18,
          ),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (stateRendererType == StateRendererType.fullScreenErrorState) {
                retryActionFunction.call();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(
              buttonTitle,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: ColorManager.white),
            ),
          ),
        ),
      ),
    );
  }
}

_isCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;

dismissDialog(BuildContext context) {
  if (_isCurrentDialogShowing(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

showRenderScreen(BuildContext context, StateRendererType stateRendererType, String message,
    {Function()? function, String title = AppStrings.success}) {
  WidgetsBinding.instance.addPostFrameCallback(
    (_) => showDialog(
      context: context,
      builder: (BuildContext context) => StateRenderer(
        stateRendererType: stateRendererType,
        message: message,
        retryActionFunction: function ?? () {},
        title: title,
      ),
    ),
  );
}
