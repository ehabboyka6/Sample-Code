import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/features/authentication/domain/entities/authentication_entity.dart';
import 'package:horsehouse/features/authentication/domain/usecases/save_auth_credential_usecase.dart';

abstract class BaseAuthenticationCredentialRepository {
  Future<Either<Failure, void>> saveAuthCredential(
      {required SaveUserCredentialParameters saveUserCredentialParameters});

  Future<Either<Failure, bool>> isExistAuthCredential();
  Future<Either<Failure, AuthenticationEntity>> getAuthCredential();
  Future<Either<Failure,void>> logOut();

}
