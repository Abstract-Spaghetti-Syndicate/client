import 'package:printer_client/core/database/app_database.dart';
import '../../domain/entities/spool_entity.dart';

class SpoolModel extends SpoolEntity {
  const SpoolModel({
    required super.id,
    required super.filamentId,
    required super.weightTotal,
    required super.weightUsed,
    super.locationId,
  });

  factory SpoolModel.fromDrift(SpoolData data) {
    return SpoolModel(
      id: data.id,
      filamentId: data.filamentId,
      weightTotal: data.weightTotal,
      weightUsed: data.weightUsed,
      locationId: data.locationId,
    );
  }

  factory SpoolModel.fromJson(Map<String, dynamic> json) {
    return SpoolModel(
      id: json['id'] as String,
      filamentId: json['filament_id'] as String,
      weightTotal: (json['weight_total'] as num).toDouble(),
      weightUsed: (json['weight_used'] as num).toDouble(),
      locationId: json['location_id'] as String?,
    );
  }

  SpoolData toDriftData() {
    return SpoolData(
      id: id,
      filamentId: filamentId,
      weightTotal: weightTotal,
      weightUsed: weightUsed,
      locationId: locationId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'filament_id': filamentId,
      'weight_total': weightTotal,
      'weight_used': weightUsed,
      'location_id': locationId,
    };
  }
}