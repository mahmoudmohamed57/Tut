import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut/app/app_prefs.dart';
import 'package:tut/app/di.dart';
import 'dart:math' as math;
import 'package:tut/data/data_source/local_data_source.dart';
import 'package:tut/presentation/resources/assets_manager.dart';
import 'package:tut/presentation/resources/language_manager.dart';
import 'package:tut/presentation/resources/routes_manager.dart';
import 'package:tut/presentation/resources/strings_manager.dart';
import 'package:tut/presentation/resources/values_manager.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p8),
        children: [
          ListTile(
            leading: SvgPicture.asset(ImageAssets.changeLangIc),
            title: Text(
              AppStrings.changeLanguage,
              style: Theme.of(context).textTheme.bodyLarge,
            ).tr(),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl(context) ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
            ),
            onTap: () {
              _changeLanguage(context);
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.contactUsIc),
            title: Text(
              AppStrings.contactUs,
              style: Theme.of(context).textTheme.bodyLarge,
            ).tr(),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl(context) ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
            ),
            onTap: () {
              _contactUs();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
            title: Text(
              AppStrings.inviteYourFriends,
              style: Theme.of(context).textTheme.bodyLarge,
            ).tr(),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl(context) ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
            ),
            onTap: () {
              _inviteFriends();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.logoutIc),
            title: Text(
              AppStrings.logout,
              style: Theme.of(context).textTheme.bodyLarge,
            ).tr(),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(isRtl(context) ? math.pi : 0),
              child: SvgPicture.asset(ImageAssets.rightArrowSettingsIc),
            ),
            onTap: () {
              _logout(context);
            },
          )
        ],
      ),
    );
  }

  bool isRtl(BuildContext context) {
    return context.locale == arabicLocal;
  }

  _changeLanguage(BuildContext context) {
    final AppPreferences appPreferences = instance<AppPreferences>();
    appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  _contactUs() {
    // its a task for you to open any webpage using URL
  }

  _inviteFriends() {
    // its a task for you to share app name to friends
  }

  _logout(BuildContext context) {
    final AppPreferences appPreferences = instance<AppPreferences>();
    appPreferences.logout();
    final LocalDataSource localDataSource = instance<LocalDataSource>();
    localDataSource.clearCache();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
