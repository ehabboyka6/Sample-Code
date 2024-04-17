import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/features/authentication/data/datasource/sign_in_data_source.dart';
import 'package:horsehouse/features/authentication/domain/entities/authentication_entity.dart';
import 'package:horsehouse/features/authentication/domain/repositories/base_sign_in_repository.dart';
import 'package:horsehouse/features/authentication/domain/usecases/sign_in_use_case.dart';
import 'package:horsehouse/features/authentication/domain/usecases/sign_up_use_case.dart';

class SignInRepository implements BaseSignInRepository {
  BaseSignInDatasource baseSignInDatasource;

  SignInRepository({required this.baseSignInDatasource});

  @override
  Future<Either<Failure, AuthenticationEntity>> signIn({required SignInParameters signInParameters}) async {
    try {
      return Right(await baseSignInDatasource.signIn(signInParameters: signInParameters));
    }  on FailureException catch (ex, s) {
      return Left(FirebaseFailure(code: ex.code, message: ex.message));
    }
  }
}
