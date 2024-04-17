import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/core/usecases/usecases.dart';
import 'package:horsehouse/features/authentication/domain/repositories/base_sign_up_repository.dart';

class SignUpUseCase extends BaseUseCases<void, UserCredentialParameters> {
  final BaseSignUpRepository baseSignUpRepository;

  SignUpUseCase({
    required this.baseSignUpRepository,
  });

  @override
  Future<Either<Failure, void>> call(UserCredentialParameters parameters) async {
    return await baseSignUpRepository.signUp(signUpParameters: parameters);
  }
}

class UserCredentialParameters extends Equatable {
  final String countryCode;
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  const UserCredentialParameters({
    required this.countryCode,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'countryCode': countryCode,
      'password': password,
    };
  }

  @override
  List<Object?> get props => [
        countryCode,
        email,
        firstName,
        lastName,
        password,
      ];
}
