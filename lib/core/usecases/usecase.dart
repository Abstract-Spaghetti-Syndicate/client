import 'package:dartz/dartz.dart';
import 'package:printer_client/core/error/failures.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}