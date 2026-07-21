import 'package:dartz/dartz.dart';
import 'package:printer_client/core/error/failures.dart';
import '../entities/spool_entity.dart';

abstract class SpoolRepository {
  Stream<List<SpoolEntity>> watchSpools();
  Future<Either<Failure, void>> addSpool(SpoolEntity spool);
}