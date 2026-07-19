import '../../domain/entities/filament.dart';

class FilamentModel extends FilamentEntity {
  const FilamentModel({
    required super.id,
    required super.name,
    required super.material,
    super.vendorId,
    super.diameter,
    super.density,
    super.colorHex,
    super.spoolWeight,
    super.peakExtruderTemp,
    super.peakBedTemp,
  });

  factory FilamentModel.fromJson(Map<String, dynamic> json) {
    return FilamentModel(
      id: json['id'] as int,
      name: json['name'] ?? 'Unknown Filament',
      material: json['material'] ?? 'PLA',
      vendorId: json['vendor_id'] as int?,
      diameter: (json['diameter'] as num?)?.toDouble() ?? 1.75,
      density: (json['density'] as num?)?.toDouble(),
      colorHex: json['color_hex'] as String?,
      spoolWeight: (json['spool_weight'] as num?)?.toInt(), // Безпечний парсинг в int
      peakExtruderTemp: (json['ext_temp'] as num?)?.toInt(), // ВИПРАВЛЕНО: тепер double безпечно стане int
      peakBedTemp: (json['bed_temp'] as num?)?.toInt(),     // ВИПРАВЛЕНО: тепер double безпечно стане int
    );
  }
}