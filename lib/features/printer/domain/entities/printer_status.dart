import 'package:equatable/equatable.dart';

class PrinterStatus extends Equatable {
  final String state; // "printing", "standby", "error" тощо
  final double extruderTemperature;
  final double extruderTargetTemperature;
  final double bedTemperature;
  final double bedTargetTemperature;
  final double progress; // від 0.0 до 1.0
  final int timeRemaining; // в секундах
  final String? videoStreamUrl; // null, якщо камери немає

  const PrinterStatus({
    required this.state,
    required this.extruderTemperature,
    required this.extruderTargetTemperature,
    required this.bedTemperature,
    required this.bedTargetTemperature,
    required this.progress,
    required this.timeRemaining,
    this.videoStreamUrl,
  });

  @override
  List<Object?> get props => [
        state,
        extruderTemperature,
        extruderTargetTemperature,
        bedTemperature,
        bedTargetTemperature,
        progress,
        timeRemaining,
        videoStreamUrl,
      ];
}