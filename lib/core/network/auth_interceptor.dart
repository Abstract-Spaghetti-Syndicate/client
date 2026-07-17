// lib/core/network/auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:printer_client/core/network/auth_event_bus.dart';
import 'package:printer_client/features/auth/data/datasources/auth_local_data_source.dart';

class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource _localDataSource;
  final AuthEventBus _eventBus; // Додали залежність

  AuthInterceptor(this._localDataSource, this._eventBus);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _localDataSource.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Якщо сервер вашого друга скинув сесію — сигналізуємо на міст
    if (err.response?.statusCode == 401) {
      _eventBus.fire(AuthBusEvent.tokenExpired);
    }
    return handler.next(err);
  }
}