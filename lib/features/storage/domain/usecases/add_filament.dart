import 'package:dartz/dartz.dart';
import 'package:printer_client/core/error/failures.dart';
import '../entities/filament_entity.dart';
import '../repositories/filament_repository.dart';

class AddFilament {
  final FilamentRepository repository;

  AddFilament(this.repository);

  Future<Either<Failure, void>> call(Filament filament) async {
    // Тут за потреби можна додати валідацію бізнес-правил
    if (filament.name.isEmpty) {
      return Left(ValidationFailure('Назва пластику не може бути порожньою'));
    }
    return await repository.addFilament(filament);
  }
}

// Додайте цей клас у ваші failures, якщо його немає: lib/core/error/failures.dart
class ValidationFailure extends Failure {
  final String message;
  const ValidationFailure(this.message);
  @override
  List<Object> get props => [message];
}