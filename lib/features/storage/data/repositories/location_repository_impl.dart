import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../models/location_model.dart';

class LocationRepositoryImpl implements LocationRepository {
  final DioClient _dioClient;

  LocationRepositoryImpl(this._dioClient);

  @override
  Future<Either<Failure, List<LocationEntity>>> getLocations() async {
    try {
      final response = await _dioClient.get('/api/locations');

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['status'] == 'success' && responseData['locations'] != null) {
          final List<dynamic> list = responseData['locations'];
          final locations = list.map((json) => LocationModel.fromJson(json)).toList();
          return Right(locations);
        }
      }
      return const Left(ServerUnreachableFailure('Некоректна відповідь сервера локацій.'));
    } on DioException catch (e) {
      return Left(ServerUnreachableFailure(e.message ?? 'Помилка мережі при завантаженні локацій.'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}