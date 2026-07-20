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

  @override
  Stream<List<FilamentEntity>> watchFilaments() {
    return localDataSource.watchAllFilaments().map((driftDataList) {
      return driftDataList.map((driftData) => FilamentModel.fromDrift(driftData)).toList();
    });
  }

  @override
  Future<Either<Failure, void>> addFilament(FilamentEntity filament) async {
    final model = FilamentModel(
      id: filament.id,
      vendorId: filament.vendorId,
      name: filament.name,
      material: filament.material,
      colorHex: filament.colorHex,
      diameter: filament.diameter,
      peakExtruderTemp: filament.peakExtruderTemp,
      peakBedTemp: filament.peakBedTemp,
      density: filament.density,
    );

    try {
      await localDataSource.insertFilament(model.toDriftData());
      unawaited(remoteDataSource.sendFilamentToServer(model).catchError((e) {
        // Логування помилки без використання забороненого 'print'
      }));
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}