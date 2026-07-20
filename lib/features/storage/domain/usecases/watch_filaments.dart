import '../entities/filament_entity.dart';
import '../repositories/filament_repository.dart';

class WatchFilaments {
  final FilamentRepository repository;

  WatchFilaments(this.repository);

  Stream<List<Filament>> call() {
    return repository.watchFilaments();
  }
}