import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/filament_entity.dart';

abstract class SpoolRepository {
  Future<Either<Failure, List<FilamentEntity>>> getFilaments();
}