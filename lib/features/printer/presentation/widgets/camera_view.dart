import 'package:flutter/material.dart';

class CameraView extends StatelessWidget {
  final String? videoStreamUrl; // Передаємо URL, якщо камера є

  const CameraView({super.key, this.videoStreamUrl});

  @override
  Widget build(BuildContext context) {
    // Тимчасово емулюємо, що камеру не знайдено (videoStreamUrl == null)
    final bool hasCamera = videoStreamUrl != null;

    if (!hasCamera) {
      return Card(
        color: Colors.blueGrey.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.videocam_off, color: Colors.white54, size: 48),
              SizedBox(height: 8),
              Text(
                'Камеру не знайдено',
                style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Перевірте підключення у Klipper',
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }

    // Якщо камера є (в майбутньому додамо реальний плеєр/WebView)
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Center(
        child: Text('Тут буде відеопотік', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}