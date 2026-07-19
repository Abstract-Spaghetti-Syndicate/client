import 'package:equatable/equatable.dart';

class FilamentEntity extends Equatable {
  final int id;
  final String name;
  final String material; // Напр. PLA, ABS, PETG
  final int? vendorId;
  final double? diameter; // Дефолт 1.75
  final double? density;  // Щільність для розрахунку залишку ваги
  final String? colorHex;
  final int? spoolWeight; // Вага порожньої котушки за замовчуванням
  final int? peakExtruderTemp;
  final int? peakBedTemp;

  const FilamentEntity({
    required this.id,
    required this.name,
    required this.material,
    this.vendorId,
    this.diameter = 1.75,
    this.density,
    this.colorHex,
    this.spoolWeight,
    this.peakExtruderTemp,
    this.peakBedTemp,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        material,
        vendorId,
        diameter,
        density,
        colorHex,
        spoolWeight,
        peakExtruderTemp,
        peakBedTemp,
      ];
}