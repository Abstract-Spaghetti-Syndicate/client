import 'package:dartz/dartz.dart';
import 'package:printer_client/core/error/failures.dart';
import '../entities/filament_entity.dart';
import '../repositories/filament_repository.dart';

class AddFilament {
  final FilamentRepository repository;

  AddFilament(this.repository);

  Future<Either<Failure, void>> call(FilamentEntity filament) async {
    if (filament.name.isEmpty) {
      return const Left(ValidationFailure('Назва пластику порожня'));
    }
    return await repository.addFilament(filament);
  }
}