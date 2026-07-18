import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/printer_status.dart';

abstract class PrinterRepository {
  // Повертає або помилку (Failure), або актуальний статус принтера
  Future<Either<Failure, PrinterStatus>> getPrinterStatus();
}