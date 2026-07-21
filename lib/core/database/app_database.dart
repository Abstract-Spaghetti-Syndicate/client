import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@DataClassName('VendorData') // 🌟 Явно вказуємо назву моделі
class VendorTables extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('FilamentData') // 🌟 Тепер цей клас точно називатиметься FilamentData
class FilamentTables extends Table {
  TextColumn get id => text()();
  TextColumn get vendorId => text().customConstraint('NOT NULL REFERENCES vendor_tables(id) ON DELETE CASCADE')();
  TextColumn get name => text()();
  TextColumn get material => text()();
  TextColumn get colorHex => text()();
  RealColumn get diameter => real().withDefault(const Constant(1.75))();
  IntColumn get peakExtruderTemp => integer().withDefault(const Constant(210))();
  IntColumn get peakBedTemp => integer().withDefault(const Constant(60))();
  RealColumn get density => real().withDefault(const Constant(1.24))();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SpoolData') // 🌟 Явно вказуємо назву моделі
class SpoolTables extends Table {
  TextColumn get id => text()();
  TextColumn get filamentId => text().customConstraint('NOT NULL REFERENCES filament_tables(id) ON DELETE CASCADE')();
  RealColumn get weightTotal => real()();
  RealColumn get weightUsed => real()();
  TextColumn get locationId => text().nullable()();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [VendorTables, FilamentTables, SpoolTables])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'filamentary.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}