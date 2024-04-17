import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/core/usecases/usecases.dart';
import 'package:horsehouse/features/authentication/domain/repositories/base_sign_up_repository.dart';

class IsEmailUniqueUseCase extends BaseUseCases<bool, String> {
  final BaseSignUpRepository baseSignUpRepository;

  IsEmailUniqueUseCase({
    required this.baseSignUpRepository,
  });

  @override
  Future<Either<Failure, bool>> call(String parameters) async {
    return await baseSignUpRepository.isEmailUnique(email: parameters);
  }
}
