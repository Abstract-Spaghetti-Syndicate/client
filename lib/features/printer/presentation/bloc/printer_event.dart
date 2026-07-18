import 'package:equatable/equatable.dart';

abstract class PrinterEvent extends Equatable {
  const PrinterEvent();

  @override
  List<Object> get props => [];
}

// Подія для запиту оновлення даних з сервера
class FetchPrinterStatus extends PrinterEvent {}