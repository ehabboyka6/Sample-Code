import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/features/authentication/domain/usecases/sign_up_use_case.dart';

abstract class BaseSignUpRepository {
  Future<Either<Failure, bool>> isEmailUnique({required String email});
  Future<Either<Failure, void>> signUp({required UserCredentialParameters signUpParameters});


}
