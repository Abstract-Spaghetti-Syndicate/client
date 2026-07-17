// lib/features/auth/domain/usecases/connect_to_server_usecase.dart
import 'package:printer_client/core/error/failures.dart';
import 'package:printer_client/features/auth/domain/repositories/server_repository.dart';

class ConnectToServerUseCase {
  final ServerRepository _repository;

  ConnectToServerUseCase(this._repository);

  Future<(Failure?, bool)> execute(String rawUrl) async {
    final trimmedUrl = rawUrl.trim();
    if (trimmedUrl.isEmpty) {
      return (const InvalidUrlFailure(), false);
    }

    // Проста, але надійна нормалізація для прототипу
    String normalizedUrl = trimmedUrl;
    if (!normalizedUrl.startsWith('http://') && !normalizedUrl.startsWith('https://')) {
      // За замовчуванням припускаємо http для локальних self-hosted інстансів
      normalizedUrl = 'http://$normalizedUrl'; 
    }

    // Перевіряємо через регулярний вираз базову валідність URL структури
    final urlRegex = RegExp(r'^https?:\/\/[^\s$.?#].[^\s]*$');
    if (!urlRegex.hasMatch(normalizedUrl)) {
      return (const InvalidUrlFailure(), false);
    }

    // Стукаємо до сервера
    final (failure, isHealthy) = await _repository.verifyServerHealth(normalizedUrl);
    
    if (isHealthy && failure == null) {
      // Якщо сервер живий — фіксуємо його адресу в системі
      await _repository.saveActiveServerUrl(normalizedUrl);
      return (null, true);
    }

    return (failure, false);
  }
}