import 'package:equatable/equatable.dart';

class SpoolEntity extends Equatable {
  final String id;
  final String filamentId;
  final double weightTotal;
  final double weightUsed;
  final String? locationId;

  const SpoolEntity({
    required this.id,
    required this.filamentId,
    required this.weightTotal,
    required this.weightUsed,
    this.locationId,
  });

  @override
  List<Object?> get props => [id, filamentId, weightTotal, weightUsed, locationId];
}