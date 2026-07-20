import 'package:printer_client/core/database/app_database.dart';
import '../models/filament_model.dart';

abstract class FilamentLocalDataSource {
  Stream<List<FilamentTableData>> watchAllFilaments();
  Future<void> insertFilament(FilamentTableData tableData);
  Future<void> cacheFilaments(List<FilamentTableData> filaments);
}

class FilamentLocalDataSourceImpl implements FilamentLocalDataSource {
  final AppDatabase database;

  FilamentLocalDataSourceImpl({required this.database});

  @override
  Stream<List<FilamentTableData>> watchAllFilaments() {
    return database.select(database.filamentTables).watch();
  }

  @override
  Future<void> insertFilament(FilamentTableData tableData) async {
    await database.into(database.filamentTables).insertOnConflictUpdate(tableData);
  }

  @override
  Future<void> cacheFilaments(List<FilamentTableData> filaments) async {
    await database.batch((batch) {
      batch.insertAll(
        database.filamentTables, 
        filaments, 
        mode: InsertMode.insertOrReplace,
      );
    });
  }
}