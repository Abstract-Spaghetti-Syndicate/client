// lib/features/printer/domain/usecases/get_printer_status.dart
import 'package:dartz/dartz.dart';
import 'package:printer_client/core/error/failures.dart';
import 'package:printer_client/core/usecases/usecase.dart';
import '../entities/printer_status.dart';
import '../repositories/printer_repository.dart';

class GetPrinterStatus implements UseCase<PrinterStatus, NoParams> {
  final PrinterRepository repository;

  GetPrinterStatus(this.repository);

  @override
  Future<Either<Failure, PrinterStatus>> call(NoParams params) async {
    return await repository.getPrinterStatus();
  }
}