import 'package:crossworduel/core/exception/config_exception.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

Future<Either<ExceptionData, Payload>> exception2either<Payload>(
    {required Future<Payload> Function() function}) async {
  try {
    return Right(await function());
  } catch (exception) {
    if (exception is DioError) {
      if (exception.error is ExceptionData) {
        return Left(exception.error! as ExceptionData);
      } else {
        return Left(
          ConfigNotIdentifiedExcD(
            objectMap: {'exception': exception.error.toString()},
          ),
        );
      }
    }
    return Left(
      ConfigNotIdentifiedExcD(
        objectMap: {'exception': exception.toString()},
      ),
    );
  }
}
