import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/filament.dart';

abstract class FilamentTabRepository {
  Future<Either<Failure, List<FilamentEntity>>> getFilaments();
}