import 'package:printer_client/core/database/app_database.dart';
import '../../domain/entities/filament_entity.dart';

class FilamentModel extends FilamentEntity {
  const FilamentModel({
    required super.id,
    required super.vendorId,
    required super.name,
    required super.material,
    required super.colorHex,
    required super.diameter,
    required super.peakExtruderTemp,
    required super.peakBedTemp,
    required super.density,
  });

  factory FilamentModel.fromDrift(FilamentData data) {
    return FilamentModel(
      id: data.id,
      vendorId: data.vendorId,
      name: data.name,
      material: data.material,
      colorHex: data.colorHex,
      diameter: data.diameter,
      peakExtruderTemp: data.peakExtruderTemp,
      peakBedTemp: data.peakBedTemp,
      density: data.density,
    );
  }

  factory FilamentModel.fromJson(Map<String, dynamic> json) {
    return FilamentModel(
      id: json['id'] as String,
      vendorId: json['vendor_id'] as String,
      name: json['name'] as String,
      material: json['material'] as String,
      colorHex: json['color_hex'] as String,
      diameter: (json['diameter'] as num).toDouble(),
      peakExtruderTemp: json['peak_extruder_temp'] as int,
      peakBedTemp: json['peak_bed_temp'] as int,
      density: (json['density'] as num).toDouble(),
    );
  }

  FilamentData toDriftData() {
    return FilamentData(
      id: id,
      vendorId: vendorId,
      name: name,
      material: material,
      colorHex: colorHex,
      diameter: diameter,
      peakExtruderTemp: peakExtruderTemp,
      peakBedTemp: peakBedTemp,
      density: density,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor_id': vendorId,
      'name': name,
      'material': material,
      'color_hex': colorHex,
      'diameter': diameter,
      'peak_extruder_temp': peakExtruderTemp,
      'peak_bed_temp': peakBedTemp,
      'density': density,
    };
  }
}