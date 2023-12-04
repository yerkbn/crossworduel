import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<Either<ExceptionData, Type>> call(Params params);
}
