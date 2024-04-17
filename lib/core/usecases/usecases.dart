import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

abstract class BaseUseCases<T, Parameters> {
  Future<Either<Failure, T>> call(Parameters parameters);
}

abstract class BaseUseCasesNoParam<T> {
  Future<Either<Failure, T>> call();
}

class NoParameters extends Equatable {
  @override
  List<Object?> get props => [];
}
