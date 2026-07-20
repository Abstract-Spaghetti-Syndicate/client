import 'package:dartz/dartz.dart';
import 'package:printer_client/core/error/failures.dart';
import '../entities/filament_entity.dart';

abstract class FilamentRepository {
  // Реактивний стрім для UI
  Stream<List<Filament>> watchFilaments();
  
  // Асинхронне додавання нового пластику
  Future<Either<Failure, void>> addFilament(Filament filament);
  
  // Фонова синхронізація (викликається сервісом синхронізації)
  Future<Either<Failure, void>> syncWithRemote();
}