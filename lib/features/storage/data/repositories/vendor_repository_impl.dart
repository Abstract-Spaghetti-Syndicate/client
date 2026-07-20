import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/vendor_entity.dart';
import '../../domain/repositories/vendor_repository.dart';
import '../models/vendor_model.dart';

class VendorRepositoryImpl implements VendorRepository {
  final DioClient _dioClient;

  VendorRepositoryImpl(this._dioClient);

  @override
  Future<Either<Failure, List<Vendor>>> getVendors() async {
    try {
      // Запит до ендпоінту виробників
      final response = await _dioClient.get('/api/vendors');

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['status'] == 'success' && responseData['vendors'] != null) {
          final List<dynamic> list = responseData['vendors'];
          final vendors = list.map((json) => VendorModel.fromJson(json)).toList();
          return Right(vendors);
        }
      }
      return const Left(ServerUnreachableFailure('Некоректна відповідь сервера виробників.'));
    } on DioException catch (e) {
      return Left(ServerUnreachableFailure(e.message ?? 'Помилка мережі при завантаженні виробників.'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}