import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../../auth/data/datasources/auth_local_data_source.dart'; // Додано джерело токенів
import '../../domain/entities/printer_status.dart';
import '../../domain/repositories/printer_repository.dart';
import '../models/printer_status_model.dart';

class PrinterRepositoryImpl implements PrinterRepository {
  final DioClient _dioClient;
  final AuthLocalDataSource _authLocalDataSource;

  PrinterRepositoryImpl(this._dioClient, this._authLocalDataSource);

  @override
  Future<Either<Failure, PrinterStatus>> getPrinterStatus() async {
    try {
      // Витягуємо токен з локального сховища клієнта
      await _authLocalDataSource.getToken();
      
      // Робимо авторизований запит на правильний ендпоінт бекенду
      final response = await _dioClient.get(
        '/printer/status',
        queryParameters: null, // Додаткові параметри відсутні
      );

      // Якщо у вашому DioClient get-метод не прокидає глобальні перехоплювачі (interceptors),
      // токен можна передати вручную через Options:
      // Options customOptions = Options(headers: {'Authorization': 'Bearer $token'});
      
      if (response.statusCode == 200 && response.data != null) {
        final model = PrinterStatusModel.fromJson(response.data);
        return Right(model);
      }
      
      return const Left(ServerUnreachableFailure('Помилка сервера: некоректна відповідь.'));
    } on DioException catch (e) {
      return Left(ServerUnreachableFailure(e.message ?? 'Не вдалося зв\'язатися з сервером принтера.'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}