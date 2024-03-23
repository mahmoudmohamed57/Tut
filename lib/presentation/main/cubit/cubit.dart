import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/presentation/main/cubit/state.dart';
import 'package:tut/presentation/main/pages/home/cubit/cubit.dart';
import 'package:tut/presentation/main/pages/home/home_page.dart';
import 'package:tut/presentation/main/pages/notifications/notifications_page.dart';
import 'package:tut/presentation/main/pages/search/search_page.dart';
import 'package:tut/presentation/main/pages/settings/settings_page.dart';
import 'package:tut/presentation/resources/strings_manager.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitialState());

  static MainCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationsPage(),
    const SettingsPage()
  ];
  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings,
  ];

  void changeBottomNavBar(int index, BuildContext context) {
    currentIndex = index;
    if (index == 0) {
      var cubit = HomeCubit.get(context);
      cubit.getHomeData();
    }
    emit(MainChangeBottomNavBarState());
  }
}
