import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/spool.dart';
import '../../domain/repositories/filament_repository.dart';
import '../models/spool_model.dart';

class FilamentRepositoryImpl implements FilamentRepository {
  final DioClient _dioClient;

  FilamentRepositoryImpl(this._dioClient);

  @override
  Future<Either<Failure, List<Spool>>> getSpools() async {
    try {
      // Робимо GET запит на ендпоінт бекенду твого друга
      final response = await _dioClient.get('/api/spools');

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;
        
        if (responseData['status'] == 'success' && responseData['spools'] != null) {
          final List<dynamic> spoolsList = responseData['spools'];
          final spools = spoolsList
              .map((jsonSpool) => SpoolModel.fromJson(jsonSpool))
              .toList();
          return Right(spools);
        }
      }
      return const Left(ServerUnreachableFailure('Некоректна відповідь сервера котушок.'));
    } on DioException catch (e) {
      return Left(ServerUnreachableFailure(e.message ?? 'Помилка мережі при завантаженні котушок.'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}