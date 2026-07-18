import '../../domain/entities/printer_status.dart';

class PrinterStatusModel extends PrinterStatus {
  const PrinterStatusModel({
    required super.state,
    required super.extruderTemperature,
    required super.extruderTargetTemperature,
    required super.bedTemperature,
    required super.bedTargetTemperature,
    required super.progress,
    required super.timeRemaining,
    super.videoStreamUrl,
  });

  factory PrinterStatusModel.fromJson(Map<String, dynamic> json) {
    // Дістаємо вкладену телеметрію бекенду
    final telemetry = json['telemetry'] as Map<String, dynamic>? ?? {};
    final temps = telemetry['temps'] as Map<String, dynamic>? ?? {};
    
    final extruder = temps['extruder'] as Map<String, dynamic>? ?? {};
    final bed = temps['bed'] as Map<String, dynamic>? ?? {};

    return PrinterStatusModel(
      state: telemetry['print_state'] ?? 'unknown',
      extruderTemperature: (extruder['current'] as num?)?.toDouble() ?? 0.0,
      extruderTargetTemperature: (extruder['target'] as num?)?.toDouble() ?? 0.0,
      bedTemperature: (bed['current'] as num?)?.toDouble() ?? 0.0,
      bedTargetTemperature: (bed['target'] as num?)?.toDouble() ?? 0.0,
      // Бекенд поки не віддає progress/time_remaining у явній формі, закладаємо дефолти
      progress: (telemetry['progress'] as num?)?.toDouble() ?? 0.0,
      timeRemaining: (telemetry['time_remaining'] as num?)?.toInt() ?? 0,
      videoStreamUrl: telemetry['video_stream_url'],
    );
  }
}