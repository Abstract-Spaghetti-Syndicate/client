import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:printer_client/core/error/failures.dart';
import '../../domain/entities/filament_entity.dart';
import '../../domain/repositories/filament_repository.dart';
import '../datasources/filament_local_data_source.dart';
import '../datasources/filament_remote_data_source.dart';
import '../models/filament_model.dart';

class FilamentRepositoryImpl implements FilamentRepository {
  final FilamentLocalDataSource localDataSource;
  final FilamentRemoteDataSource remoteDataSource;

  FilamentRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  // 🌟 UI підписується на цей стрім і миттєво реагує на зміни в базі даних
  @override
  Stream<List<Filament>> watchFilaments() {
    return localDataSource.watchAllFilaments().map((driftDataList) {
      return driftDataList.map((driftData) => FilamentModel.fromDrift(driftData)).toList();
    });
  }

  @override
  Future<Either<Failure, void>> addFilament(Filament filament) async {
    final model = FilamentModel(
      id: filament.id,
      vendorId: filament.vendorId,
      name: filament.name,
      material: filament.material,
      colorHex: filament.colorHex,
    );

    try {
      // Крок 1: Миттєво пишемо в локальну БД (Offline-First)
      await localDataSource.insertFilament(model.toDriftData());

      // Крок 2: Оптимістично намагаємось синхронізувати з сервером
      // В реальному масштабованому додатку це можна також винести в чергу задач (Background Queue)
      unawaited(remoteDataSource.sendFilamentToServer(model).catchError((e) {
        // Якщо сервер недоступний — нічого страшного, дані вже в базі й синхронізуються пізніше
        print("Фонова синхронізація не вдалася, збережено локально: $e");
      }));

      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> syncWithRemote() async {
    try {
      // Отримуємо свіжі дані з сервера
      final remoteData = await remoteDataSource.fetchRemoteFilaments();
      // Оновлюємо локальний кеш
      final driftData = remoteData.map((m) => m.toDriftData()).toList();
      await localDataSource.cacheFilaments(driftData);
      
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

// Додайте ці класи у failures.dart, якщо вони відсутні
class DatabaseFailure extends Failure {
  final String message;
  const DatabaseFailure(this.message);
  @override
  List<Object> get props => [message];
}
class ServerFailure extends Failure {
  final String message;
  const ServerFailure(this.message);
  @override
  List<Object> get props => [message];
}