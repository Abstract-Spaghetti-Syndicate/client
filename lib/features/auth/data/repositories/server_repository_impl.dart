// lib/features/auth/data/repositories/server_repository_impl.dart
import 'package:dio/dio.dart';
import 'package:printer_client/core/error/failures.dart';
import 'package:printer_client/features/auth/domain/repositories/server_repository.dart';

class ServerRepositoryImpl implements ServerRepository {
  final Dio _dio;
  // Тут буде ваша Isar або Shared Preferences для локального збереження
  // final LocalStorage _localStorage; 

  ServerRepositoryImpl(this._dio) {
    // Налаштовуємо жорсткі ліміти для запобігання Socket Hang
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);
  }

  @override
  Future<(Failure?, bool)> verifyServerHealth(String normalizedUrl) async {
    try {
      // Робимо легкий запит на перевірку працездатності бекенду вашого друга
      final response = await _dio.get(
        '$normalizedUrl/api/v1/health',
        options: Options(validateStatus: (status) => status == 200),
      );

      if (response.statusCode == 200) {
        return (null, true);
      }
      return (ServerUnreachableFailure('Сервер повернув код: ${response.statusCode}'), false);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        return (const ServerUnreachableFailure('Перевищено час очікування відповіді від сервера.'), false);
      }
      if (e.type == DioExceptionType.badResponse) {
        return (ServerUnreachableFailure('Сервер відхилив запит: ${e.response?.statusCode}'), false);
      }
      return (ServerUnreachableFailure('Мережева помилка: ${e.message}'), false);
    } catch (e) {
      return (UnknownFailure(e.toString()), false);
    }
  }

  @override
  Future<void> saveActiveServerUrl(String url) async {
    // Реалізація запису в локальну БД (Isar / SecureStorage)
    // _localStorage.write('active_server', url);
  }
}