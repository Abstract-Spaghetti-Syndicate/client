import 'package:drift/drift.dart';
import 'package:printer_client/core/database/app_database.dart';

abstract class FilamentLocalDataSource {
  Stream<List<FilamentData>> watchAllFilaments();
  Future<void> insertFilament(FilamentData tableData);
  Future<void> cacheFilaments(List<FilamentData> filaments);
}

class FilamentLocalDataSourceImpl implements FilamentLocalDataSource {
  final AppDatabase database;

  FilamentLocalDataSourceImpl({required this.database});

  @override
  Stream<List<FilamentData>> watchAllFilaments() {
    return database.select(database.filamentTables).watch();
  }

  @override
  Future<void> insertFilament(FilamentData tableData) async {
    await database.into(database.filamentTables).insertOnConflictUpdate(tableData);
  }

  @override
  Future<void> cacheFilaments(List<FilamentData> filaments) async {
    await database.batch((batch) {
      batch.insertAll(
        database.filamentTables, 
        filaments, 
        mode: InsertMode.insertOrReplace,
      );
    });
  }
}