// lib/features/auth/domain/repositories/server_repository.dart
import 'package:printer_client/core/error/failures.dart';

abstract interface class ServerRepository {
  /// Перевіряє доступність сервера за вказаним URL.
  /// Повертає [Failure] у разі помилки, або `true` у разі успішного "pong".
  Future<(Failure?, bool)> verifyServerHealth(String normalizedUrl);
  
  /// Зберігає валідований URL у локальне сховище.
  Future<void> saveActiveServerUrl(String url);
}