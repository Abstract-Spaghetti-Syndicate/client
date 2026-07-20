import 'package:printer_client/core/database/app_database.dart';
import '../../domain/entities/filament_entity.dart';

class FilamentModel extends FilamentEntity {
  const FilamentModel({
    required super.id,
    required super.vendorId,
    required super.name,
    required super.material,
    required super.colorHex,
  });

  // Конвертація з Drift структури в Entity
  factory FilamentModel.fromDrift(FilamentTableData data) {
    return FilamentModel(
      id: data.id,
      vendorId: data.vendorId,
      name: data.name,
      material: data.material,
      colorHex: data.colorHex,
    );
  }

  // Конвертація з JSON (від сервера) в Entity
  factory FilamentModel.fromJson(Map<String, dynamic> json) {
    return FilamentModel(
      id: json['id'] as String,
      vendorId: json['vendor_id'] as String,
      name: json['name'] as String,
      material: json['material'] as String,
      colorHex: json['color_hex'] as String,
    );
  }

  // Конвертація Entity у рядок для збереження в Drift
  FilamentTableData toDriftData() {
    return FilamentTableData(
      id: id,
      vendorId: vendorId,
      name: name,
      material: material,
      colorHex: colorHex,
    );
  }

  // Конвертація в JSON для відправки на сервер
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor_id': vendorId,
      'name': name,
      'material': material,
      'color_hex': colorHex,
    };
  }
}