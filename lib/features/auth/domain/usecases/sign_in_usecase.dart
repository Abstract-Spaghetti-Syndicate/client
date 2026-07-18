// lib/features/auth/domain/usecases/sign_in_usecase.dart
import 'package:printer_client/core/error/failures.dart';
import 'package:printer_client/features/auth/domain/entities/user_credentials.dart';
import 'package:printer_client/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _repository;

  const SignInUseCase(this._repository);

  /// Виконання сценарію входу. 
  /// Dart 3 дозволяє використовувати метод `call`, що робить виклик об'єкта подібним до функції.
  Future<(Failure?, String?)> call(UserCredentials credentials) async {
    // Domain-валідація (Останній рубіж перед відправкою в мережу)
    if (credentials.email.trim().isEmpty || credentials.password.isEmpty) {
      return (const InvalidUrlFailure(), null); // Можна замінити на суто InvalidCredentialsFailure
    }

    if (credentials.password.length < 6) {
      return (const ServerUnreachableFailure('Пароль занадто короткий на рівні правил безпеки.'), null);
    }

    // Передаємо чисту сутність далі по конвеєру до шару даних
    return await _repository.signInWithCredentials(credentials);
  }
}