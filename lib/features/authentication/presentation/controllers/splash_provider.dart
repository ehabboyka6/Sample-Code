import 'package:flutter/material.dart';
import 'package:horsehouse/core/services/dependency_injection_services.dart';
import 'package:horsehouse/core/services/navigation_services.dart';
import 'package:horsehouse/core/utils/user_manger.dart';
import 'package:horsehouse/features/authentication/domain/usecases/get_auth_credential_use_case.dart';
import 'package:horsehouse/features/authentication/domain/usecases/is_exist_auth_credential_use_case.dart';
import 'package:horsehouse/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:horsehouse/features/products/presentation/screens/products_screen.dart';

import '../../../../core/utils/app_constants.dart';

class SplashProvider with ChangeNotifier {
  ///constructor
  SplashProvider({required this.vsync}) {
    initializeSplash();
  }

  /// var
  late AnimationController controller;
  late Animation<double> animation;
  late TickerProvider vsync;

  ///initialize Splash
  void initializeSplash() async {
    controller = AnimationController(
      vsync: vsync,
      duration: AppConstance.splashDuration,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
    await Future.delayed(AppConstance.splashDuration);

    if (await _isExistUserCredential()) {
      await _setUserCredentialAndMove();
    } else {
      NavigationService.navigateTo(
          navigationMethod: NavigationMethod.pushReplacement, page: () => const SignInScreen());
    }
  }

  Future<bool> _isExistUserCredential() async {
    return (await sl<IsExistAuthCredentialUseCase>()()).fold((l) async {
      UserManager.logout();
      return false;
    }, (r) async {
      return r;
    });
  }

  Future<void> _setUserCredentialAndMove() async {
    return (await sl<GetAuthCredentialUseCase>()()).fold((l) async {
      UserManager.logout();
      NavigationService.navigateTo(
          navigationMethod: NavigationMethod.pushReplacement, page: () => const SignInScreen());
    }, (r) async {
      UserManager.authenticationEntity = r;
      NavigationService.navigateTo(navigationMethod: NavigationMethod.pushReplacement, page: () => const ProductsScreen());
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
