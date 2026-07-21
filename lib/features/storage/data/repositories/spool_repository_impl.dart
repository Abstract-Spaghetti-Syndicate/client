import 'package:dartz/dartz.dart';
import 'package:printer_client/core/error/failures.dart';
import '../../domain/entities/spool_entity.dart';
import '../../domain/repositories/spool_repository.dart';

class SpoolRepositoryImpl implements SpoolRepository {
  @override
  Stream<List<SpoolEntity>> watchSpools() {
    return Stream.value([]);
  }

  @override
  Future<Either<Failure, void>> addSpool(SpoolEntity spool) async {
    try {
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}