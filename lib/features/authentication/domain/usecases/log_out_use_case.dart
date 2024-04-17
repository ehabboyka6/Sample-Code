import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/core/usecases/usecases.dart';
import 'package:horsehouse/features/authentication/domain/repositories/base_authentication_credential_repository.dart';

class LogOutUseCase extends BaseUseCasesNoParam<void> {
  BaseAuthenticationCredentialRepository baseAuthenticationCredentialRepository;

  LogOutUseCase({required this.baseAuthenticationCredentialRepository});

  @override
  Future<Either<Failure, void>> call() async {
    return await baseAuthenticationCredentialRepository.logOut();
  }
}
