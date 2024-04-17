import 'package:horsehouse/core/services/dependency_injection_services.dart';
import 'package:horsehouse/features/authentication/domain/entities/authentication_entity.dart';
import 'package:horsehouse/features/authentication/domain/usecases/log_out_use_case.dart';
import 'package:horsehouse/features/authentication/domain/usecases/save_auth_credential_usecase.dart';

class UserManager {
  static AuthenticationEntity? authenticationEntity;

  static Future<void> setUserAuthModel({required SaveUserCredentialParameters saveUserCredentialParameters}) async {
    await sl<SaveAuthCredentialUseCase>()(saveUserCredentialParameters);
    authenticationEntity = AuthenticationEntity(
        firstName: saveUserCredentialParameters.firstName,
        lastName: saveUserCredentialParameters.lastName,
        email: saveUserCredentialParameters.email,
        countryCode: saveUserCredentialParameters.countryCode);
  }

  static Future<void> logout() async {
    _clearCachedUser();
  }

  static Future<void> _clearCachedUser() async {
    authenticationEntity = null;
    await sl<LogOutUseCase>()();
  }
}
