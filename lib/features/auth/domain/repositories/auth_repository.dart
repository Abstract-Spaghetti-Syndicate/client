// lib/features/auth/domain/repositories/auth_repository.dart
import 'package:printer_client/core/error/failures.dart';
import 'package:printer_client/features/auth/domain/entities/user_credentials.dart';

abstract interface class AuthRepository {
  /// Виконує запит автентифікації на сервері за допомогою Email та Паролю.
  /// Повертає [Failure] у разі помилки, або рядок з токеном у разі успіху.
  Future<(Failure?, String?)> signInWithCredentials(UserCredentials credentials);
}