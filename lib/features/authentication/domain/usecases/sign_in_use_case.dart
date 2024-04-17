import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/core/usecases/usecases.dart';
import 'package:horsehouse/features/authentication/domain/entities/authentication_entity.dart';
import 'package:horsehouse/features/authentication/domain/repositories/base_sign_in_repository.dart';

class SignInUseCase extends BaseUseCases<AuthenticationEntity, SignInParameters> {
  final BaseSignInRepository baseSignInRepository;

  SignInUseCase({
    required this.baseSignInRepository,
  });

  @override
  Future<Either<Failure, AuthenticationEntity>> call(SignInParameters parameters) async {
    return await baseSignInRepository.signIn(signInParameters: parameters);
  }
}

class SignInParameters extends Equatable {
  final String email;
  final String password;

  const SignInParameters({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
