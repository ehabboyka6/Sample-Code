import 'package:fl_country_code_picker/fl_country_code_picker.dart' as fl;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horsehouse/core/integrated_library/country_code_picker/country_code_picker.dart';
import 'package:horsehouse/core/services/dependency_injection_services.dart';
import 'package:horsehouse/core/services/navigation_services.dart';
import 'package:horsehouse/core/utils/app_string.dart';
import 'package:horsehouse/core/utils/common_function.dart';
import 'package:horsehouse/core/utils/user_manger.dart';
import 'package:horsehouse/core/widget/dialog_service.dart';
import 'package:horsehouse/features/authentication/domain/usecases/is_email_unique_use_case.dart';
import 'package:horsehouse/features/authentication/domain/usecases/save_auth_credential_usecase.dart';
import 'package:horsehouse/features/authentication/domain/usecases/sign_up_use_case.dart';
import 'package:horsehouse/features/products/presentation/screens/products_screen.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_sizes.dart';
import '../utils/constants.dart';

class SignUpProvider with ChangeNotifier {
  ///controller
  TextEditingController firstTextEditingController = TextEditingController();
  TextEditingController lastTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController = TextEditingController();

  ///var
  bool isSignUpLoading = false;
  bool showPassword = false;
  final formKey = GlobalKey<FormState>();
  fl.CountryCode? countryCode;

  ///focus
  bool firstNameHasFocus = false;
  bool lastNameHasFocus = false;
  bool emailHasFocus = false;
  bool passwordHasFocus = false;
  bool confirmPasswordHasFocus = false;

  get isKeyboardVisible =>
      firstNameHasFocus || lastNameHasFocus || emailHasFocus || passwordHasFocus || confirmPasswordHasFocus;

  ///validation for First Name
  String? validateFirstName(String firstName) {
    if (firstNameHasFocus) return null;
    if (firstName.isEmpty) {
      return null;
    } else if (!checkPattern(pattern: r"^[a-zA-Zء-ي ]+$", value: firstName.trim())) {
      return tr(AppString.firstNameAcceptLettersOnly);
    } else if (firstName.length < 2) {
      return tr(AppString.firstNameMustBeAtLeast2Characters);
    }
    return null;
  }

  ///on First Name  focus change
  void onFirstNameFocusChange(bool focus) {
    firstNameHasFocus = focus;
    notifyListeners();
    if (!firstNameHasFocus) {
      validateForm();
    }
  }

  ///validation for Last Name
  String? validateLastName(String firstName) {
    if (lastNameHasFocus) return null;
    if (firstName.isEmpty) {
      return null;
    } else if (!checkPattern(pattern: r"^[a-zA-Zء-ي ]+$", value: firstName.trim())) {
      return tr(AppString.secondNameAcceptLettersOnly);
    } else if (firstName.trim().length < 2) {
      return tr(AppString.secondNameMustBeAtLeast2Characters);
    }
    return null;
  }

  ///on First Name  focus change
  void onLastNameFocusChange(bool focus) {
    lastNameHasFocus = focus;
    notifyListeners();
    if (!lastNameHasFocus) {
      validateForm();
    }
  }

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
    } else if (password.length < passwordMinLength || !_passwordRegexChecker(password)) {
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

  ///validation for Confirm password
  String? validateConfirmPassword(String password) {
    if (confirmPasswordHasFocus) return null;
    if (password.isEmpty) {
      return null;
    } else if (passwordEditingController.text != confirmPasswordEditingController.text) {
      return tr(AppString.passwordDoesntMatch);
    } else if (password.isEmpty) {
      return tr(AppString.confirmPasswordEmpty);
    } else if (password.length < passwordMinLength || !_passwordRegexChecker(password)) {
      return tr(AppString.passwordCriteriaInvalid);
    }
    return null;
  }

  ///on confirm Password focus change
  void onConfirmPasswordFocusChange(bool focus) {
    confirmPasswordHasFocus = focus;
    notifyListeners();
    if (!confirmPasswordHasFocus) {
      validateForm();
    }
  }

  ///password criteria
  bool _passwordRegexChecker(String password) {
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    if ((hasUppercase || hasLowercase) && hasDigits) {
      return true;
    }
    return false;
  }

  ///change obscure Password
  void changePasswordState() {
    showPassword = !showPassword;
    notifyListeners();
  }

  ///fire validation and return if is Valid
  bool validateForm() {
    notifyListeners();
    return formKey.currentState!.validate();
  }

  Future<void> selectCountry(context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    fl.CountryCode? countryCode = await const FlCountryCodePicker(
      localize: true,
    ).showPicker(selectedCode: this.countryCode?.code, context: context, pickerMaxHeight: AppSizes.ph700);
    if (countryCode != null) {
      this.countryCode = countryCode;
    }
    notifyListeners();
  }

  /// is Enable Sign In Button
  bool isEnableSignUpButton() {
    return (firstTextEditingController.text.isNotEmpty &&
        lastTextEditingController.text.isNotEmpty &&
        emailTextEditingController.text.isNotEmpty &&
        passwordEditingController.text.isNotEmpty &&
        confirmPasswordEditingController.text.isNotEmpty &&
        countryCode != null);
  }

  ///sign up
  Future<void> signUp() async {
    if (validateForm()) {
      isSignUpLoading = true;
      notifyListeners();
      bool result = await _isEmailUniqueToRegister();
      if (result) {
        final UserCredentialParameters userCredentialParameters = UserCredentialParameters(
            firstName: firstTextEditingController.text,
            lastName: lastTextEditingController.text,
            email: emailTextEditingController.text,
            countryCode: countryCode!.name,
            password: passwordEditingController.text);
        (await sl<SignUpUseCase>()(userCredentialParameters)).fold((l) async {
          await DialogWidget.showCustomDialog(
            context: Get.context!,
            title: l.message,
            buttonName: tr(AppString.ok),
          );
        }, (r) async {
          await UserManager.setUserAuthModel(
              saveUserCredentialParameters: SaveUserCredentialParameters(
                  email: userCredentialParameters.email,
                  countryCode: userCredentialParameters.countryCode,
                  lastName: userCredentialParameters.lastName,
                  firstName: userCredentialParameters.firstName));
          NavigationService.offAll(page: () => const ProductsScreen());
        });
      }
      isSignUpLoading = false;
      notifyListeners();
    }
  }

  Future<bool> _isEmailUniqueToRegister() async {
    return (await sl<IsEmailUniqueUseCase>()(emailTextEditingController.text)).fold((l) async {
      await DialogWidget.showCustomDialog(
        context: Get.context!,
        title: l.message,
        buttonName: tr(AppString.ok),
      );
      return false;
    }, (r) {
      return r;
    });
  }

  ///Go To Sign In Screen
  void goToSignInScreen() async {
    NavigationService.goBack();
  }
}
