import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/presentation/main/cubit/cubit.dart';
import 'package:tut/presentation/main/cubit/state.dart';
import 'package:tut/presentation/resources/color_manager.dart';
import 'package:tut/presentation/resources/strings_manager.dart';
import 'package:tut/presentation/resources/values_manager.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: ColorManager.white,
                  ),
            ).tr(),
          ),
          body: cubit.pages[cubit.currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ColorManager.lightGrey,
                  spreadRadius: AppSize.s1,
                )
              ],
            ),
            child: BottomNavigationBar(
              selectedItemColor: ColorManager.primary,
              unselectedItemColor: ColorManager.grey,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index, context);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: AppStrings.home,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: AppStrings.search,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: AppStrings.notifications,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: AppStrings.settings,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
