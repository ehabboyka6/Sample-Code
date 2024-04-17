import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/features/authentication/data/datasource/authentication_credential_datasource.dart';
import 'package:horsehouse/features/authentication/domain/entities/authentication_entity.dart';
import 'package:horsehouse/features/authentication/domain/repositories/base_authentication_credential_repository.dart';
import 'package:horsehouse/features/authentication/domain/usecases/save_auth_credential_usecase.dart';

class AuthenticationCredentialRepository extends BaseAuthenticationCredentialRepository {
  final BaseAuthenticationCredentialDatasource baseAuthenticationCredentialDatasource;

  AuthenticationCredentialRepository(this.baseAuthenticationCredentialDatasource);

  @override
  Future<Either<Failure, void>> saveAuthCredential(
      {required SaveUserCredentialParameters saveUserCredentialParameters}) async {
    try {
      return Right(await baseAuthenticationCredentialDatasource.saveAuthCredential(
          saveUserCredentialParameters: saveUserCredentialParameters));
    }  on FailureException catch (ex, s)  {
      return Left(CacheFailure(code: ex.code, message: ex.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isExistAuthCredential() async {
    try {
      return Right(await baseAuthenticationCredentialDatasource.isExistAuthCredential());
    }  on FailureException catch (ex, s)  {
      return Left(CacheFailure(code: ex.code, message: ex.message));
    }
  }

  @override
  Future<Either<Failure, AuthenticationEntity>> getAuthCredential() async {
    try {
      return Right(await baseAuthenticationCredentialDatasource.getAuthCredential());
    }  on FailureException catch (ex, s)  {
      return Left(CacheFailure(code: ex.code, message: ex.message));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      return Right(await baseAuthenticationCredentialDatasource.logOut());
    }  on FailureException catch (ex, s)  {
      return Left(CacheFailure(code: ex.code, message: ex.message));
    }
  }
}
