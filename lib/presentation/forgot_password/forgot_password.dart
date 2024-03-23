import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut/app/functions.dart';
import 'package:tut/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut/presentation/forgot_password/cubit/cubit.dart';
import 'package:tut/presentation/forgot_password/cubit/state.dart';
import 'package:tut/presentation/resources/assets_manager.dart';
import 'package:tut/presentation/resources/color_manager.dart';
import 'package:tut/presentation/resources/strings_manager.dart';
import 'package:tut/presentation/resources/values_manager.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();

    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordLoadingState) {
          dismissDialog(context);
          showRenderScreen(
            context,
            StateRendererType.popupLoadingState,
            AppStrings.loading,
          );
        } else if (state is ForgotPasswordFailureState) {
          dismissDialog(context);
          showRenderScreen(
            context,
            StateRendererType.popupErrorState,
            state.failure,
          );
        } else {
          dismissDialog(context);
          if (state is ForgotPasswordSuccessState) {
            showRenderScreen(
              context,
              StateRendererType.popupSuccess,
              'Your password is : ${state.password}',
              title: AppStrings.success,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = ForgotPasswordCubit.get(context);
        return Scaffold(
          body: Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.only(top: AppPadding.p100),
            color: ColorManager.white,
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
                      child: SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                          onPressed: () => cubit.forgotPassword(
                            email: emailController.text,
                          ),
                          child: Text(
                            AppStrings.getPassword,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: ColorManager.white,
                                ),
                          ).tr(),
                        ),
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
