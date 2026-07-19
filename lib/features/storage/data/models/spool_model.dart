import '../../domain/entities/spool.dart';

class SpoolModel extends Spool {
  const SpoolModel({
    required super.id,
    required super.vendor,
    required super.name,
    required super.material,
    required super.initialWeight,
    required super.usedWeight,
    super.colorHex,
  });

  factory SpoolModel.fromJson(Map<String, dynamic> json) {
    return SpoolModel(
      id: json['id'] as int,
      vendor: json['vendor'] ?? 'Unknown',
      name: json['name'] ?? 'Spool',
      material: json['material'] ?? 'PLA',
      initialWeight: (json['initial_weight'] as num?)?.toDouble() ?? 1000.0,
      usedWeight: (json['used_weight'] as num?)?.toDouble() ?? 0.0,
      colorHex: json['color_hex'],
    );
  }
}