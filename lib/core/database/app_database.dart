import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// 1. Таблиця Вендорів (Виробників)
class VendorTables extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  
  @override
  Set<Column> get primaryKey => {id};
}

// 2. Таблиця Типів Пластику (Філаментів)
class FilamentTables extends Table {
  TextColumn get id => text()();
  TextColumn get vendorId => text().customConstraint('REFERENCES vendor_tables(id) ON DELETE CASCADE')();
  TextColumn get name => text()(); // Наприклад: "Premium PLA"
  TextColumn get material => text()(); // PLA, PETG, ABS, ASA
  TextColumn get colorHex => text()(); // Колір для UI (#FF0000)
  
  @override
  Set<Column> get primaryKey => {id};
}

// 3. Таблиця конкретних Котушок
class SpoolTables extends Table {
  TextColumn get id => text()();
  TextColumn get filamentId => text().customConstraint('REFERENCES filament_tables(id) ON DELETE CASCADE')();
  RealColumn get weightTotal => real()(); // Початкова вага (наприклад, 1000.0)
  RealColumn get weightUsed => real()();  // Використано грам
  TextColumn get locationId => text().nullable()(); // Де лежить (коробка, сушарка)
  
  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [VendorTables, FilamentTables, SpoolTables])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1; // Збільшувати при зміні структури (міграціях)
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'filamentary.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}