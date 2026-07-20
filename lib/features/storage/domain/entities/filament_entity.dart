import 'package:equatable/equatable.dart';

class Filament extends Equatable {
  final String id;
  final String vendorId;
  final String name;
  final String material;
  final String colorHex;

  const Filament({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.material,
    required this.colorHex,
  });

  @override
  List<Object?> get props => [id, vendorId, name, material, colorHex];
}