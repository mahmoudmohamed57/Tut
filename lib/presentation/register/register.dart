import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/app/app_prefs.dart';
import 'package:tut/app/constant.dart';
import 'package:tut/app/di.dart';
import 'package:tut/app/functions.dart';
import 'package:tut/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut/presentation/register/cubit/cubit.dart';
import 'package:tut/presentation/register/cubit/state.dart';
import 'package:tut/presentation/resources/assets_manager.dart';
import 'package:tut/presentation/resources/color_manager.dart';
import 'package:tut/presentation/resources/routes_manager.dart';
import 'package:tut/presentation/resources/strings_manager.dart';
import 'package:tut/presentation/resources/values_manager.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController mobileNumberController =
        TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          dismissDialog(context);
          showRenderScreen(
            context,
            StateRendererType.popupLoadingState,
            AppStrings.loading,
          );
        } else if (state is RegisterFailureState) {
          dismissDialog(context);
          showRenderScreen(
            context,
            StateRendererType.popupErrorState,
            state.failure,
          );
        } else {
          dismissDialog(context);
          if (state is RegisterSuccessState) {
            final AppPreferences appPreferences = instance<AppPreferences>();
            appPreferences.setUserLoggedIn();
            Navigator.pushReplacementNamed(context, Routes.mainRoute);
          }
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.only(top: AppPadding.p28),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Center(
                      child: Image(image: AssetImage(ImageAssets.splashLogo)),
                    ),
                    const SizedBox(height: AppSize.s28),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppPadding.p28,
                        right: AppPadding.p28,
                      ),
                      child: defaultFormField(
                        context: context,
                        controller: userNameController,
                        type: TextInputType.name,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your name';
                          }
                          return null;
                        },
                        label: 'User Name',
                        prefixIcon: Icons.person,
                      ),
                    ),
                    const SizedBox(height: AppSize.s18),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: AppPadding.p28,
                          right: AppPadding.p28,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CountryCodePicker(
                                flagWidth: 20,
                                onChanged: (country) {
                                  cubit.setCountryCode(
                                    country.dialCode ?? Constant.token,
                                  );
                                },
                                initialSelection: '+20',
                                favorite: const ['+39', 'FR', "+966"],
                                showFlag: true,
                                hideMainText: true,
                                showOnlyCountryWhenClosed: true,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: defaultFormField(
                                context: context,
                                controller: mobileNumberController,
                                type: TextInputType.name,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your mobile Number';
                                  }
                                  return null;
                                },
                                label: 'mobile Number',
                                prefixIcon: Icons.person,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSize.s18),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppPadding.p28,
                        right: AppPadding.p28,
                      ),
                      child: defaultFormField(
                        context: context,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                          return null;
                        },
                        label: 'Email Address',
                        prefixIcon: Icons.email_outlined,
                      ),
                    ),
                    const SizedBox(height: AppSize.s18),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppPadding.p28,
                        right: AppPadding.p28,
                      ),
                      child: defaultFormField(
                        context: context,
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        suffixIcon: RegisterCubit.get(context).suffix,
                        isPassword: RegisterCubit.get(context).isPassword,
                        suffixPressed: () {
                          RegisterCubit.get(context).changePasswordVisibility();
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'password is too short';
                          }
                          return null;
                        },
                        label: 'Password',
                        prefixIcon: Icons.lock_outline,
                      ),
                    ),
                    const SizedBox(height: AppSize.s40),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppPadding.p28,
                        right: AppPadding.p28,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                          onPressed: () {
                            cubit.register(
                              userName: userNameController.text,
                              countryMobileCode: cubit.countryMobileCode,
                              mobileNumber: mobileNumberController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          },
                          child: Text(
                            AppStrings.register,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: ColorManager.white),
                          ).tr(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: AppPadding.p18,
                        left: AppPadding.p28,
                        right: AppPadding.p28,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          AppStrings.alreadyHaveAccount,
                          style: Theme.of(context).textTheme.titleSmall,
                        ).tr(),
                      ),
                    ),
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
