import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/features/authentication/data/datasource/sign_up_data_source.dart';
import 'package:horsehouse/features/authentication/domain/repositories/base_sign_up_repository.dart';
import 'package:horsehouse/features/authentication/domain/usecases/sign_up_use_case.dart';

class SignUpRepository implements BaseSignUpRepository {
  BaseSignUpDatasource baseSignUpDatasource;

  SignUpRepository({required this.baseSignUpDatasource});

  @override
  Future<Either<Failure, bool>> isEmailUnique({required String email}) async {
    try {
      return Right(await baseSignUpDatasource.isEmailUnique(email: email));
    }  on FailureException catch (ex, s) {
      return Left(FirebaseFailure(code: ex.code, message: ex.message));
    }
  }

  @override
  Future<Either<Failure, void>> signUp({required UserCredentialParameters signUpParameters}) async {
    try {
      return Right(await baseSignUpDatasource.signUp(signUpParameters: signUpParameters));
    }  on FailureException catch (ex, s)  {
      return Left(FirebaseFailure(code: ex.code, message: ex.message));
    }
  }
}
