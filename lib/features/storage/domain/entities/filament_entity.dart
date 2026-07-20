import 'package:equatable/equatable.dart';

class FilamentEntity extends Equatable {
  final String id;
  final String vendorId;
  final String name;
  final String material;
  final String colorHex;
  final double diameter;          // Діаметр (наприклад, 1.75)
  final int peakExtruderTemp;     // Температура хотенду (°C)
  final int peakBedTemp;          // Температура столу (°C)
  final double density;          // Щільність матеріалу (г/см³)

  const FilamentEntity({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.material,
    required this.colorHex,
    required this.diameter,
    required this.peakExtruderTemp,
    required this.peakBedTemp,
    required this.density,
  });

  @override
  List<Object?> get props => [
        id,
        vendorId,
        name,
        material,
        colorHex,
        diameter,
        peakExtruderTemp,
        peakBedTemp,
        density,
      ];
}