import 'package:dio/dio.dart';
import '../models/filament_model.dart';

abstract class FilamentRemoteDataSource {
  Future<List<FilamentModel>> fetchRemoteFilaments();
  Future<void> sendFilamentToServer(FilamentModel model);
}

class FilamentRemoteDataSourceImpl implements FilamentRemoteDataSource {
  final Dio dio; // Ваш зконфігорований DioClient

  FilamentRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<FilamentModel>> fetchRemoteFilaments() async {
    final response = await dio.get('/api/v1/storage/filaments');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => FilamentModel.fromJson(json)).toList();
    } else {
      throw DioException(requestOptions: response.requestOptions, response: response);
    }
  }

  @override
  Future<void> sendFilamentToServer(FilamentModel model) async {
    await dio.post('/api/v1/storage/filaments', data: model.toJson());
  }
}