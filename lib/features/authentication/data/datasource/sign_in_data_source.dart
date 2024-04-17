import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/core/global/localization/app_localization.dart';
import 'package:horsehouse/core/network/firestore_caller.dart';
import 'package:horsehouse/core/network/firestore_path.dart';
import 'package:horsehouse/core/services/dependency_injection_services.dart';
import 'package:horsehouse/core/utils/app_string.dart';
import 'package:horsehouse/features/authentication/data/models/authentication_model.dart';
import 'package:horsehouse/features/authentication/domain/entities/authentication_entity.dart';
import 'package:horsehouse/features/authentication/domain/usecases/sign_in_use_case.dart';

abstract class BaseSignInDatasource {
  Future<AuthenticationEntity> signIn({required SignInParameters signInParameters});
}

class SignInDatasource implements BaseSignInDatasource {
  @override
  Future<AuthenticationEntity> signIn({required SignInParameters signInParameters}) async {
    return await sl<FireStoreCaller>().getDocument(
      path: '${FireStorePath.userCollectionPath}/${signInParameters.email}',
      builder: (data) {
        if (data != null) {
          AuthenticationModel authenticationModel = AuthenticationModel.fromJson(data);
          if (authenticationModel.isMatchUser(
              email: signInParameters.email, password: signInParameters.password, json: data)) {
            return authenticationModel;
          } else {

            throw FailureException(message:tr(AppString.checkThePassword),code: 0);
          }
        } else {
          throw FailureException(message:tr(AppString.noAccountWithThisEmail),code: 0);
        }
      },
    );


  }
}
