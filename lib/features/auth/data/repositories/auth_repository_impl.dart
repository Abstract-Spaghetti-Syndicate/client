// lib/features/auth/data/repositories/auth_repository_impl.dart
import 'package:dio/dio.dart';
import 'package:printer_client/core/error/failures.dart';
import 'package:printer_client/core/network/dio_client.dart';
import 'package:printer_client/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:printer_client/features/auth/domain/entities/user_credentials.dart';
import 'package:printer_client/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DioClient _dioClient;
  final AuthLocalDataSource _localDataSource;

  const AuthRepositoryImpl(this._dioClient, this._localDataSource);

  @override
  Future<(Failure?, String?)> signInWithCredentials(UserCredentials credentials) async {
    try {
      // Виконуємо чистий POST запит за стандартом REST API
      final response = await _dioClient.post<Map<String, dynamic>>(
        '/api/v1/auth/login',
        data: {
          'email': credentials.email,
          'password': credentials.password,
        },
      );

      // Оскільки Dio конфігуровано з validateStatus на 200, успіх гарантовано тут
      final data = response.data;
      if (data != null && data.containsKey('token')) {
        final token = data['token'] as String;
        
        // Відразу фіксуємо токен на диску в SecureStorage
        await _localDataSource.saveToken(token);
        return (null, token);
      }

      return (const UnknownFailure('Сервер повернув порожню відповідь або некоректний формат даних.'), null);
      
    } on DioException catch (e) {
      // Санітарна обробка виключень Dio
      return (_handleDioError(e), null);
    } catch (e) {
      // Обробка непередбачуваних системних збоїв (наприклад, збій пам'яті)
      return (UnknownFailure('Критична системна помилка: $e'), null);
    }
  }

  /// Ізольований метод мапування технічних помилок у бізнес-об'єкти
  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const ServerUnreachableFailure('Перевищено час очікування. Перевірте підключення до сервера.');
        
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return const ServerUnreachableFailure('Невірний email або пароль.');
        }
        if (statusCode == 422) {
          return const ServerUnreachableFailure('Введені дані не пройшли валідацію сервера.');
        }
        return ServerUnreachableFailure('Помилка сервера: Код $statusCode');
        
      case DioExceptionType.connectionError:
        return const ServerUnreachableFailure('Сервер вашого друга недоступний. Перевірте мережу або домен.');
        
      default:
        return UnknownFailure('Мережевий збій: ${error.message}');
    }
  }
}