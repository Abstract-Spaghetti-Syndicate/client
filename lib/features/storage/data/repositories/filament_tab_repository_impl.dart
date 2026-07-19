import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/filament.dart';
import '../../domain/repositories/filament_tab_repository.dart';
import '../models/filament_model.dart';

class FilamentTabRepositoryImpl implements FilamentTabRepository {
  final DioClient _dioClient;

  FilamentTabRepositoryImpl(this._dioClient);

  @override
  Future<Either<Failure, List<FilamentEntity>>> getFilaments() async {
    try {
      final response = await _dioClient.get('/api/filaments');

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['status'] == 'success' && responseData['filaments'] != null) {
          final List<dynamic> list = responseData['filaments'];
          final filaments = list.map((json) => FilamentModel.fromJson(json)).toList();
          return Right(filaments);
        }
      }
      return const Left(ServerUnreachableFailure('Некоректна відповідь сервера філаментів.'));
    } on DioException catch (e) {
      return Left(ServerUnreachableFailure(e.message ?? 'Помилка мережі при завантаженні філаментів.'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}