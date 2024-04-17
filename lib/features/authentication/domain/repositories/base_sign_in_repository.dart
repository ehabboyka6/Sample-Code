import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/features/authentication/domain/entities/authentication_entity.dart';
import 'package:horsehouse/features/authentication/domain/usecases/sign_in_use_case.dart';
import 'package:horsehouse/features/authentication/domain/usecases/sign_up_use_case.dart';

abstract class BaseSignInRepository {
  Future<Either<Failure, AuthenticationEntity>> signIn({required SignInParameters signInParameters});

}
