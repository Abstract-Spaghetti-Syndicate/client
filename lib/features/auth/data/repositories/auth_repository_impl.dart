// lib/features/auth/data/repositories/auth_repository_impl.dart
import 'package:dio/dio.dart';

// Інфраструктурні імпорти ядра
import 'package:printer_client/core/error/failures.dart';
import 'package:printer_client/core/network/dio_client.dart';

// Доменні та дата-моделі фічі
import 'package:printer_client/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:printer_client/features/auth/domain/entities/user_credentials.dart';
import 'package:printer_client/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DioClient _dioClient;
  final AuthLocalDataSource _localDataSource;

  // Конструктор жорстко вимагає ін'єкції залежностей (SOLID Dependency Inversion)
  const AuthRepositoryImpl(this._dioClient, this._localDataSource);

  @override
  Future<(Failure?, String?)> signInWithCredentials(UserCredentials credentials) async {
    try {
      // Динамічно мутуємо базовий URL під конкретний сервер (self-hosted концепція)
      _dioClient.updateBaseUrl(credentials.serverUrl);

      final response = await _dioClient.post<Map<String, dynamic>>(
        '/api/auth/login', 
        data: {
          'email': credentials.email,
          'password': credentials.password,
        },
      );
      
      final data = response.data;
      if (data != null && data.containsKey('token')) {
        final token = data['token'] as String;
        
        // Фіксуємо токен у SecureStorage на диску
        await _localDataSource.saveToken(token);
        return (null, token);
      }
      
      return (const UnknownFailure('Помилка структури JSON: відсутній токен у відповіді'), null);
    } on DioException catch (e) {
      return (_handleDioError(e), null);
    } catch (e) {
      return (UnknownFailure('Непередбачуваний системний збій: $e'), null);
    }
  }

  /// Чистий санітарний мапувальник помилок
  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const ServerUnreachableFailure('Перевищено час очікування. Перевірте підключення або статус IP.');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return const ServerUnreachableFailure('Невірний пароль адміністратора.');
        }
        return ServerUnreachableFailure('Помилка API сервера: Код $statusCode');
      case DioExceptionType.connectionError:
        return const ServerUnreachableFailure('Мережа сервера недоступна. Перевірте публічний домен.');
      default:
        return UnknownFailure('Мережевий збій: ${error.message}');
    }
  }
}