import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/core/usecases/usecases.dart';
import 'package:horsehouse/features/authentication/domain/repositories/base_authentication_credential_repository.dart';

class IsExistAuthCredentialUseCase extends BaseUseCasesNoParam<bool > {
  BaseAuthenticationCredentialRepository baseAuthenticationCredentialRepository;

  IsExistAuthCredentialUseCase({required this.baseAuthenticationCredentialRepository});

  @override
  Future<Either<Failure, bool>> call() async {
    return await baseAuthenticationCredentialRepository.isExistAuthCredential();
  }
}