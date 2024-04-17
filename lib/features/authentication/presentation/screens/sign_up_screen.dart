import 'package:flutter/material.dart';
import 'package:horsehouse/core/utils/app_string.dart';
import 'package:horsehouse/features/authentication/presentation/component/logo_component.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/widget/custom_elevated_button.dart';
import '../../../../core/widget/custom_links.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/custom_text_form_field.dart';
import '../component/first_and_last_name_component.dart';
import '../controllers/sign_up_provider.dart';
import '../utils/constants.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: ChangeNotifierProvider(
        create: (context) => SignUpProvider(),
        child: Consumer<SignUpProvider>(
          builder: (context, provider, child) => Form(
            key: provider.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///logo
                  const LogoComponent(),

                  SizedBox(
                    height: AppSizes.ph18,
                  ),

                  ///first name , last name
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
                    child: const FirstAndLastNameComponent(),
                  ),
                  SizedBox(
                    height: AppSizes.ph12,
                  ),

                  ///email
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
                    child: CustomTextFormField(
                      controller: provider.emailTextEditingController,
                      prefixIconTextFieldState: IconTextFieldState.email,
                      labelText: tr(AppString.email),
                      maxLength: emailMaxDigits,
                      onFocusChange: provider.onEmailFocusChange,
                      validator: (value) => provider.validateEmail(value!),
                      onChanged: (value) {
                        provider.validateForm();
                      },
                    ),
                  ),
                  SizedBox(
                    height: AppSizes.ph12,
                  ),

                  ///Country
                  GestureDetector(
                      onTap: () async {
                        await provider.selectCountry(context);
                      },
                      child: AbsorbPointer(
                        absorbing: true,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
                          child: CustomTextFormField(
                            prefixIconTextFieldState: IconTextFieldState.country,
                            labelText: tr(AppString.country),
                            validator: (p0) => null,
                            readonly: true,
                            controller: TextEditingController(text: provider.countryCode?.localize(context).name ?? ''),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: AppSizes.ph12,
                  ),

                  ///password
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
                    child: CustomTextFormField(
                      prefixIconTextFieldState: IconTextFieldState.lock,
                      controller: provider.passwordEditingController,
                      obscureText: !provider.showPassword,
                      validator: (password) => provider.validatePassword(password!),
                      suffixIconTextFieldState:
                          provider.showPassword ? IconTextFieldState.notObscure : IconTextFieldState.obscure,
                      labelText: tr(AppString.password),
                      suffixOnPressed: () => provider.changePasswordState(),
                      onChanged: (_) {
                        provider.validateForm();
                      },
                      onFocusChange: provider.onPasswordFocusChange,
                    ),
                  ),

                  /// password Criteria
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.pw8),
                    child: CustomText(
                      tr(AppString.passwordCriteria),
                      textStyle: Theme.of(context).inputDecorationTheme.labelStyle!.copyWith(fontSize: AppSizes.sp12),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: AppSizes.ph12,
                  ),

                  ///confirm password
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
                    child: CustomTextFormField(
                      prefixIconTextFieldState: IconTextFieldState.lock,
                      controller: provider.confirmPasswordEditingController,
                      obscureText: !provider.showPassword,
                      validator: (password) => provider.validateConfirmPassword(password!),
                      suffixIconTextFieldState:
                          provider.showPassword ? IconTextFieldState.notObscure : IconTextFieldState.obscure,
                      labelText: tr(AppString.confirmPassword),
                      suffixOnPressed: () => provider.changePasswordState(),
                      onChanged: (_) {
                        provider.validateForm();
                      },
                      onFocusChange: provider.onConfirmPasswordFocusChange,
                    ),
                  ),

                  /// password Criteria
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.pw8),
                    child: CustomText(
                      tr(AppString.passwordCriteria),
                      textStyle: Theme.of(context).inputDecorationTheme.labelStyle!.copyWith(fontSize: AppSizes.sp12),
                      textAlign: TextAlign.start,
                    ),
                  ),

                  SizedBox(
                    height: AppSizes.ph12,
                  ),

                  ///sign up button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
                    child: CustomElevatedButton(
                      onPressed: () => provider.signUp(),
                      isLoading: provider.isSignUpLoading,
                      text: tr(AppString.signUp),
                      isEnabled: provider.isEnableSignUpButton(),
                    ),
                  ),
                  SizedBox(
                    height: AppSizes.ph24,
                  ),

                  ///go to sign up screen
                  CustomLink(
                    prefixText: tr(AppString.haveAnAccount),
                    linkText: tr(AppString.signIn),
                    linkAction: () => provider.goToSignInScreen(),
                  ),
                  SizedBox(
                    height: provider.isKeyboardVisible ? AppSizes.heightFullScreen * 1 / 2 : AppSizes.ph32,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
