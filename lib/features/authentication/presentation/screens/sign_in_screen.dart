import 'package:flutter/material.dart';
import 'package:horsehouse/core/services/status_bar_manager.dart';
import 'package:horsehouse/core/utils/app_string.dart';
import 'package:horsehouse/features/authentication/presentation/component/logo_component.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/widget/custom_elevated_button.dart';
import '../../../../core/widget/custom_links.dart';
import '../../../../core/widget/custom_text_form_field.dart';
import '../controllers/sign_in_provider.dart';
import '../utils/constants.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatusBarManager.setLikeBackgroundColor(context: context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ChangeNotifierProvider(
        create: (context) => SignInProvider(),
        child: Consumer<SignInProvider>(
          builder: (context, provider, child) => Form(
            key: provider.formKey,
            child: Column(
              children: [
                const LogoComponent(),

                SizedBox(
                  height: AppSizes.ph18,
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

                ///password
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
                  child: CustomTextFormField(
                    prefixIconTextFieldState: IconTextFieldState.lock,
                    controller: provider.passwordEditingController,
                    labelText: tr(AppString.password),
                    obscureText: !provider.showPassword,
                    validator: (password) => provider.validatePassword(password!),
                    suffixIconTextFieldState:
                        provider.showPassword ? IconTextFieldState.notObscure : IconTextFieldState.obscure,
                    suffixOnPressed: () => provider.changePasswordState(),
                    onChanged: (_) {
                      provider.validateForm();
                    },
                    onFocusChange: provider.onPasswordFocusChange,
                  ),
                ),

                ///forget password
                Padding(
                  padding: EdgeInsets.only(bottom: AppSizes.pw32, top: AppSizes.ph12, right: AppSizes.pw14),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CustomLink(
                      linkText: tr(AppString.forgetPassword),
                      prefixText: '',
                      linkAction: () => provider.gotoForgetPasswordScreen(),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSizes.ph8,
                ),

                ///sign in button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
                  child: CustomElevatedButton(
                    onPressed: () => provider.signIn(),
                    isLoading: provider.isSignInLoading,
                    text: tr(AppString.signIn),
                    isEnabled: provider.isEnableSignInButton(),
                  ),
                ),
                SizedBox(
                  height: AppSizes.ph24,
                ),

                ///go to sign out screen
                CustomLink(
                  prefixText: tr(AppString.notAMemberYet),
                  linkText: tr(AppString.signUpNow),
                  linkAction: () => provider.goToSignUpScreen(),
                ),
                SizedBox(
                  height: AppSizes.ph32,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
