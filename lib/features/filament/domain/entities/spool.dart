import 'package:equatable/equatable.dart';

class Spool extends Equatable {
  final int id;
  final String vendor;
  final String name;
  final String material;
  final double initialWeight;
  final double usedWeight;
  final String? colorHex;

  const Spool({
    required this.id,
    required this.vendor,
    required this.name,
    required this.material,
    required this.initialWeight,
    required this.usedWeight,
    this.colorHex,
  });

  // Обчислювана властивість: скільки пластику залишилось
  double get remainingWeight => initialWeight - usedWeight;

  // Обчислювана властивість: відсоток залишку для прогрес-бару
  double get remainingPercentage {
    if (initialWeight <= 0) return 0.0;
    final pct = (remainingWeight / initialWeight) * 100;
    return pct.clamp(0.0, 100.0);
  }

  @override
  List<Object?> get props => [
        id,
        vendor,
        name,
        material,
        initialWeight,
        usedWeight,
        colorHex,
      ];
}