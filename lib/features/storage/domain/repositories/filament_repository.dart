import 'package:dartz/dartz.dart';
import 'package:printer_client/core/error/failures.dart';
import '../entities/filament_entity.dart';

abstract class FilamentRepository {
  Stream<List<FilamentEntity>> watchFilaments();
  Future<Either<Failure, void>> addFilament(FilamentEntity filament);
}