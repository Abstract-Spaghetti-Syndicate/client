import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio.options
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 5)
      ..responseType = ResponseType.json;
  }

  Dio get instance => _dio;

  void updateBaseUrl(String url) {
    var formattedUrl = url.trim();
    if (!formattedUrl.startsWith('http://') && !formattedUrl.startsWith('https://')) {
      formattedUrl = 'http://$formattedUrl';
    }
    _dio.options.baseUrl = formattedUrl;
  }

  // Додаємо цей метод для GET запитів, щоб не смикати instance щоразу:
  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get<T>(path, queryParameters: queryParameters);
  }

  Future<Response<T>> post<T>(String path, {dynamic data}) async {
    return await _dio.post<T>(path, data: data);
  }
}