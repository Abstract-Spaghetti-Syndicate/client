// lib/features/auth/presentation/pages/splash_page.dart
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Використовуємо Scaffold як базис для коректного накладання Material-constraints
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Тут згодом буде твій кастомний векторний логотип Filamentary
            Icon(
              Icons.print_rounded, 
              size: 64, 
              color: Colors.deepOrange,
            ),
            SizedBox(height: 24),
            CircularProgressIndicator.adaptive(),
          ],
        ),
      ),
    );
  }
}