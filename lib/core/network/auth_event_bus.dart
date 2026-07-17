// lib/core/network/auth_event_bus.dart
import 'dart:async';

/// Сигнали, які можуть надходити з глибин мережевого шару
enum AuthBusEvent { tokenExpired }

class AuthEventBus {
  // Використовуємо broadcast, щоб підписників могло бути декілька (наприклад, BLoC + логувальник)
  final _controller = StreamController<AuthBusEvent>.broadcast();

  Stream<AuthBusEvent> get stream => _controller.stream;

  /// Сповістити систему про подію авторизації
  void fire(AuthBusEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  void dispose() {
    _controller.close();
  }
}