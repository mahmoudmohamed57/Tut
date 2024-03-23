import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/domain/model/models.dart';
import 'package:tut/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut/presentation/details/cubit/cubit.dart';
import 'package:tut/presentation/details/cubit/state.dart';
import 'package:tut/presentation/resources/color_manager.dart';
import 'package:tut/presentation/resources/strings_manager.dart';
import 'package:tut/presentation/resources/values_manager.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        if (state is DetailsFailureState) {
          dismissDialog(context);
          showRenderScreen(
            context,
            StateRendererType.fullScreenErrorState,
            state.failure,
          );
          return Container();
        } else if (state is DetailsSuccessState) {
          dismissDialog(context);
          return _getContentScreen(state.data, context);
        } else {
          dismissDialog(context);
          showRenderScreen(
            context,
            StateRendererType.fullScreenLoadingState,
            AppStrings.loading,
          );
          if (state is DetailsInitialState) {
            var cubit = DetailsCubit.get(context);
            cubit.getDetailsData();
          }
          return Container();
        }
      },
    );
  }

  Widget _getContentScreen(data, BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: const Text(AppStrings.storeDetails).tr(),
        elevation: AppSize.s0,
        iconTheme: IconThemeData(color: ColorManager.white),
        backgroundColor: ColorManager.primary,
        centerTitle: true,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: ColorManager.white,
        child: SingleChildScrollView(child: _getItems(data, context)),
      ),
    );
  }

  Widget _getItems(Details details, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.network(
            details.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 250,
          ),
        ),
        _getSection(AppStrings.details, context),
        _getInfoText(details.details, context),
        _getSection(AppStrings.services, context),
        _getInfoText(details.services, context),
        _getSection(AppStrings.about, context),
        _getInfoText(details.about, context)
      ],
    );
  }

  Widget _getSection(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p12,
        left: AppPadding.p12,
        right: AppPadding.p12,
        bottom: AppPadding.p2,
      ),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium).tr(),
    );
  }

  Widget _getInfoText(String info, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s12),
      child: Text(info, style: Theme.of(context).textTheme.bodySmall).tr(),
    );
  }
}
