import 'package:equatable/equatable.dart';
import '../../domain/entities/printer_status.dart';

abstract class PrinterState extends Equatable {
  const PrinterState();
  
  @override
  List<Object?> get props => [];
}

class PrinterInitial extends PrinterState {}

// Додали необов'язкове поле status. Якщо воно є, ми покажемо старі дані під час фонового оновлення
class PrinterLoading extends PrinterState {
  final PrinterStatus? oldStatus;

  const PrinterLoading({this.oldStatus});

  @override
  List<Object?> get props => [oldStatus];
}

class PrinterLoaded extends PrinterState {
  final PrinterStatus status;

  const PrinterLoaded(this.status);

  @override
  List<Object?> get props => [status];
}

class PrinterError extends PrinterState {
  final String message;
  final PrinterStatus? oldStatus; // Утримуємо дані навіть при помилці мережі

  const PrinterError(this.message, {this.oldStatus});

  @override
  List<Object?> get props => [message, oldStatus];
}