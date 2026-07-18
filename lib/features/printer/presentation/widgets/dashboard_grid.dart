import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../domain/entities/printer_status.dart';
import 'camera_view.dart';

class DashboardGrid extends StatelessWidget {
  final PrinterStatus status;

  const DashboardGrid({super.key, required this.status});

  int _getCrossAxisCount(double width) {
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }

  Widget _buildStatusCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      color: Colors.grey.shade900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(value,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = _getCrossAxisCount(screenWidth);

    // Переводимо прогрес у відсотки для виведення
    final int progressPercent = (status.progress * 100).toInt();
    // Форматуємо час, що залишився (секунди у хвилини)
    final int minutesRemaining = (status.timeRemaining / 60).ceil();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: StaggeredGrid.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              // Блок камери (відображає реальний статус лінка)
              StaggeredGridTile.count(
                crossAxisCellCount: crossAxisCount == 1 ? 1 : 2,
                mainAxisCellCount: 1.2,
                child: CameraView(videoStreamUrl: status.videoStreamUrl),
              ),
              // Метрики моніторингу з живими даними
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 0.5,
                child: _buildStatusCard(
                    'Екструдер',
                    '${status.extruderTemperature.toStringAsFixed(1)}°C / ${status.extruderTargetTemperature.toStringAsFixed(0)}°C',
                    Icons.local_fire_department,
                    Colors.deepOrange),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 0.5,
                child: _buildStatusCard(
                    'Стіл',
                    '${status.bedTemperature.toStringAsFixed(1)}°C / ${status.bedTargetTemperature.toStringAsFixed(0)}°C',
                    Icons.layers,
                    Colors.blue),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: crossAxisCount == 4 ? 2 : 1,
                mainAxisCellCount: 0.5,
                child: _buildStatusCard(
                    'Статус друку',
                    status.state == 'printing'
                        ? '$progressPercent% (Залишилось $minutesRemainingхв)'
                        : status.state.toUpperCase(),
                    Icons.hourglass_top,
                    status.state == 'printing' ? Colors.green : Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
