import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:horsehouse/core/services/dependency_injection_services.dart';
import 'package:horsehouse/core/utils/app_string.dart';
import 'package:horsehouse/core/utils/user_manger.dart';
import 'package:horsehouse/core/widget/dialog_service.dart';
import 'package:horsehouse/features/authentication/domain/usecases/save_auth_credential_usecase.dart';
import 'package:horsehouse/features/authentication/domain/usecases/sign_in_use_case.dart';
import 'package:horsehouse/features/products/presentation/screens/products_screen.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/services/navigation_services.dart';
import '../screens/sign_up_screen.dart';
import '../utils/constants.dart';

class SignInProvider with ChangeNotifier {
  ///constructor
  SignInProvider();

  ///controller
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  ///var
  bool isSignInLoading = false;
  bool showPassword = false;
  final formKey = GlobalKey<FormState>();
  bool emailHasFocus = false;
  bool passwordHasFocus = false;

  ///validation for email
  String? validateEmail(String value) {
    if (emailHasFocus) return null;
    const String emailPattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    if (value.isEmpty) {
      return null;
    } else if (!RegExp(emailPattern).hasMatch(value)) {
      return tr(AppString.emailIsNotCorrect);
    } else {
      return null;
    }
  }

  ///on email focus change
  void onEmailFocusChange(bool focus) {
    emailHasFocus = focus;
    notifyListeners();
    if (!emailHasFocus) {
      validateForm();
    }
  }

  ///validation for password
  String? validatePassword(String password) {
    if (passwordHasFocus) return null;
    if (password.isEmpty) {
      return null;
    } else if (password.length < passwordMinLength) {
      return tr(AppString.passwordCriteriaInvalid);
    }
    return null;
  }

  ///on Password focus change
  void onPasswordFocusChange(bool focus) {
    passwordHasFocus = focus;
    notifyListeners();
    if (!passwordHasFocus) {
      validateForm();
    }
  }

  ///change obscure Password
  void changePasswordState() {
    showPassword = !showPassword;
    notifyListeners();
  }

  /// is Enable Sign In Button
  bool isEnableSignInButton() {
    return (emailTextEditingController.text.isNotEmpty && passwordEditingController.text.isNotEmpty);
  }

  ///fire validation and return if is Valid
  bool validateForm() {
    notifyListeners();
    return formKey.currentState!.validate();
  }

  ///Go To Sign Up Screen
  void goToSignUpScreen() async {
    NavigationService.navigateTo(navigationMethod: NavigationMethod.push, page: () => const SignUpScreen());
  }

  ///Go to ForgetPasswordScreen
  void gotoForgetPasswordScreen() {
    ///TODO : Ehab not implemented yet
  }

  ///sign in
  Future<void> signIn() async {
    if (validateForm()) {
      isSignInLoading = true;
      notifyListeners();
      (await sl<SignInUseCase>()(SignInParameters(
              email: emailTextEditingController.text.trim(), password: passwordEditingController.text.trim())))
          .fold((l) async {
        await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonName: tr(AppString.ok),
        );
      }, (r) async {
        await UserManager.setUserAuthModel(
            saveUserCredentialParameters: SaveUserCredentialParameters(
                firstName: r.firstName, lastName: r.lastName, countryCode: r.countryCode, email: r.email));
        NavigationService.offAll(page: () => const ProductsScreen());
      });

      isSignInLoading = false;
      notifyListeners();
    }
  }
}
