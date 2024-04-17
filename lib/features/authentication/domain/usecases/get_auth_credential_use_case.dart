import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/core/usecases/usecases.dart';
import 'package:horsehouse/features/authentication/domain/entities/authentication_entity.dart';
import 'package:horsehouse/features/authentication/domain/repositories/base_authentication_credential_repository.dart';

class GetAuthCredentialUseCase extends BaseUseCasesNoParam<AuthenticationEntity> {
  BaseAuthenticationCredentialRepository baseAuthenticationCredentialRepository;

  GetAuthCredentialUseCase({required this.baseAuthenticationCredentialRepository});

  @override
  Future<Either<Failure, AuthenticationEntity>> call() async {
    return await baseAuthenticationCredentialRepository.getAuthCredential();
  }
}
