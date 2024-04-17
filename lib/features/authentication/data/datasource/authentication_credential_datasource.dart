import 'dart:convert';

import 'package:horsehouse/core/local_data/shared_preferences_services.dart';
import 'package:horsehouse/core/services/dependency_injection_services.dart';
import 'package:horsehouse/core/utils/app_constants.dart';
import 'package:horsehouse/features/authentication/data/models/authentication_model.dart';
import 'package:horsehouse/features/authentication/domain/entities/authentication_entity.dart';
import 'package:horsehouse/features/authentication/domain/usecases/save_auth_credential_usecase.dart';

abstract class BaseAuthenticationCredentialDatasource {
  Future<void> saveAuthCredential({
    required SaveUserCredentialParameters saveUserCredentialParameters,
  });

  Future<bool> isExistAuthCredential();

  Future<AuthenticationEntity> getAuthCredential();

  Future<void> logOut();
}

class AuthenticationCredentialDatasource implements BaseAuthenticationCredentialDatasource {
  @override
  Future<void> saveAuthCredential({required SaveUserCredentialParameters saveUserCredentialParameters}) async {
    await sl<SharedPreferencesServices>().saveData(
      key: AppConstance.authCredential,
      value: json.encode(saveUserCredentialParameters.toMap()),
      dataType: DataType.string,
    );
  }

  @override
  Future<bool> isExistAuthCredential() async {
    return sl<SharedPreferencesServices>().checkByKey(key: AppConstance.authCredential);
  }

  @override
  Future<AuthenticationEntity> getAuthCredential() async {
   Map<String,dynamic> userData= json.decode(await sl<SharedPreferencesServices>().getData(
      key: AppConstance.authCredential,
      dataType: DataType.string,
    ));
    return AuthenticationModel.fromJson(userData);
  }

  @override
  Future<void> logOut() async {
    await sl<SharedPreferencesServices>().clearKey(
      key: AppConstance.authCredential,
    );
  }
}
