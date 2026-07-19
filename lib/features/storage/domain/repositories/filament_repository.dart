import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/spool.dart';

abstract class FilamentRepository {
  // Метод повертає або архітектурну помилку Failure, або список котушок Spool
  Future<Either<Failure, List<Spool>>> getSpools();
}