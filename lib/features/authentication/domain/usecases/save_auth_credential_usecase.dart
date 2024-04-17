import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/core/usecases/usecases.dart';
import 'package:horsehouse/features/authentication/domain/repositories/base_authentication_credential_repository.dart';

class SaveAuthCredentialUseCase extends BaseUseCases<void, SaveUserCredentialParameters> {
  BaseAuthenticationCredentialRepository baseAuthenticationCredentialRepository;

  SaveAuthCredentialUseCase({required this.baseAuthenticationCredentialRepository});

  @override
  Future<Either<Failure, void>> call(SaveUserCredentialParameters parameters) async {
    return await baseAuthenticationCredentialRepository.saveAuthCredential(saveUserCredentialParameters: parameters);
  }
}

class SaveUserCredentialParameters extends Equatable {
  final String countryCode;
  final String email;
  final String firstName;
  final String lastName;

  const SaveUserCredentialParameters({
    required this.countryCode,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'countryCode': countryCode,
    };
  }

  @override
  List<Object?> get props => [
        countryCode,
        email,
        firstName,
        lastName,
      ];
}
