import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/app/app_prefs.dart';
import 'package:tut/app/di.dart';
import 'package:tut/app/functions.dart';
import 'package:tut/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut/presentation/login/cubit/cubit.dart';
import 'package:tut/presentation/login/cubit/state.dart';
import 'package:tut/presentation/resources/assets_manager.dart';
import 'package:tut/presentation/resources/color_manager.dart';
import 'package:tut/presentation/resources/routes_manager.dart';
import 'package:tut/presentation/resources/strings_manager.dart';
import 'package:tut/presentation/resources/values_manager.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          dismissDialog(context);
          showRenderScreen(
            context,
            StateRendererType.popupLoadingState,
            AppStrings.loading,
          );
        } else if (state is LoginFailureState) {
          dismissDialog(context);
          showRenderScreen(
            context,
            StateRendererType.popupErrorState,
            state.failure,

          );
        } else {
          dismissDialog(context);
          if (state is LoginSuccessState) {
            final AppPreferences appPreferences = instance<AppPreferences>();
            appPreferences.setUserLoggedIn();
            Navigator.pushReplacementNamed(context, Routes.mainRoute);
          }
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.white,
          body: Container(
            padding: const EdgeInsets.only(top: AppPadding.p50),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Image(image: AssetImage(ImageAssets.splashLogo)),
                    const SizedBox(height: AppSize.s28),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppPadding.p28,
                        right: AppPadding.p28,
                      ),
                      child: defaultFormField(
                        context: context,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                          return null;
                        },
                        label: 'Email Address',
                        prefixIcon: Icons.email_outlined,
                      ),
                    ),
                    const SizedBox(height: AppSize.s28),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppPadding.p28,
                        right: AppPadding.p28,
                      ),
                      child: defaultFormField(
                        context: context,
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        suffixIcon: cubit.suffix,
                        isPassword: cubit.isPassword,
                        suffixPressed: () {
                          cubit.changePasswordVisibility();
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'password is too short';
                          }
                          return null;
                        },
                        label: 'Password',
                        prefixIcon: Icons.lock_outline,
                      ),
                    ),
                    const SizedBox(height: AppSize.s28),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppPadding.p28,
                        right: AppPadding.p28,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: 'sign in',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: AppPadding.p8,
                        left: AppPadding.p20,
                        right: AppPadding.p20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.forgotPasswordRoute,
                              );
                            },
                            child: Text(
                              AppStrings.forgetPassword,
                              style: Theme.of(context).textTheme.titleSmall,
                            ).tr(),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.registerRoute,
                              );
                            },
                            child: Text(
                              AppStrings.registerText,
                              style: Theme.of(context).textTheme.titleSmall,
                            ).tr(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
