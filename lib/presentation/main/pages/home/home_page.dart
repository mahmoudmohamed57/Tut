import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/domain/model/models.dart';
import 'package:tut/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut/presentation/main/pages/home/cubit/cubit.dart';
import 'package:tut/presentation/main/pages/home/cubit/state.dart';
import 'package:tut/presentation/resources/color_manager.dart';
import 'package:tut/presentation/resources/routes_manager.dart';
import 'package:tut/presentation/resources/strings_manager.dart';
import 'package:tut/presentation/resources/values_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeFailureState) {
          dismissDialog(context);
          showRenderScreen(
            context,
            StateRendererType.fullScreenErrorState,
            state.failure,
          );
          return Container();
        } else if (state is HomeSuccessState) {
          dismissDialog(context);
          return _getContentScreen(state.data.data, context);
        } else {
          dismissDialog(context);
          showRenderScreen(
            context,
            StateRendererType.fullScreenLoadingState,
            AppStrings.loading,
          );
          return Container();
        }
      },
    );
  }

  Widget _getContentScreen(data, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getBannersCarousel(data.banners),
          _getSection(AppStrings.services, context),
          _getServices(data.services, context),
          _getSection(AppStrings.stores, context),
          _getStores(data.stores, context)
        ],
      ),
    );
  }

  Widget _getBannersCarousel(List<BannerAd>? banners) {
    if (banners != null) {
      return CarouselSlider(
        items: banners
            .map(
              (banner) => SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: AppSize.s1_5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    side: BorderSide(
                      color: ColorManager.primary,
                      width: AppSize.s1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    child: Image.network(banner.image, fit: BoxFit.cover),
                  ),
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: AppSize.s190,
          autoPlay: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getSection(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p12,
        left: AppPadding.p12,
        right: AppPadding.p12,
        bottom: AppPadding.p2,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ).tr(),
    );
  }

  Widget _getServices(List<Service>? services, BuildContext context) {
    if (services != null) {
      return Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.p12,
          right: AppPadding.p12,
        ),
        child: Container(
          height: AppSize.s160,
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: services
                .map(
                  (service) => Card(
                    elevation: AppSize.s4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      side: BorderSide(
                        color: ColorManager.white,
                        width: AppSize.s1,
                      ),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          child: Image.network(
                            service.image,
                            fit: BoxFit.cover,
                            width: AppSize.s120,
                            height: AppSize.s120,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: AppPadding.p8),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              service.title,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ).tr(),
                          ),
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStores(List<Store>? stores, BuildContext context) {
    if (stores != null) {
      return Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.p12,
          right: AppPadding.p12,
          top: AppPadding.p12,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisCount: AppSize.s2,
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                stores.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.detailsRoute);
                    },
                    child: Card(
                      elevation: AppSize.s4,
                      child: Image.network(
                        stores[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
