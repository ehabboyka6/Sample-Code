import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/core/global/localization/app_localization.dart';
import 'package:horsehouse/core/network/firestore_caller.dart';
import 'package:horsehouse/core/network/firestore_path.dart';
import 'package:horsehouse/core/services/dependency_injection_services.dart';
import 'package:horsehouse/core/utils/app_string.dart';
import 'package:horsehouse/features/authentication/domain/usecases/sign_up_use_case.dart';

abstract class BaseSignUpDatasource {
  Future<bool> isEmailUnique({required String email});

  Future<void> signUp({required UserCredentialParameters signUpParameters});
}

class SignUpDatasource implements BaseSignUpDatasource {
  @override
  Future<void> signUp({required UserCredentialParameters signUpParameters}) async {
    await sl<FireStoreCaller>().setDocument(
      path: FireStorePath.userCollectionPath,
      docId: signUpParameters.email,
      data: signUpParameters.toMap(),
    );
  }

  @override
  Future<bool> isEmailUnique({required String email}) async {
    return await sl<FireStoreCaller>().getDocument(
      path: '${FireStorePath.userCollectionPath}/$email',
      builder: (data) {
        if (data == null) {
          return true;
        } else {
          throw FailureException(message: tr(AppString.thisEmailIsRegisterBefore),code: 0);
        }
      },
    );
  }
}
