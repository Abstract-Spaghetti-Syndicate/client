import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/printer_status.dart';
import '../../domain/repositories/printer_repository.dart';
import 'printer_event.dart';
import 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  final PrinterRepository _repository;

  PrinterBloc(this._repository) : super(PrinterInitial()) {
    on<FetchPrinterStatus>(_onFetchPrinterStatus);
  }

  Future<void> _onFetchPrinterStatus(
    FetchPrinterStatus event,
    Emitter<PrinterState> emit,
  ) async {
    // Запам'ятовуємо старі дані, якщо вони є в поточному стані
    PrinterStatus? currentStatus;
    if (state is PrinterLoaded) {
      currentStatus = (state as PrinterLoaded).status;
    } else if (state is PrinterLoading) {
      currentStatus = (state as PrinterLoading).oldStatus;
    }

    // Емітимо завантаження, але зберігаємо старі дані на екрані
    emit(PrinterLoading(oldStatus: currentStatus));
    
    final result = await _repository.getPrinterStatus();
    
    result.fold(
      (failure) => emit(PrinterError('Не вдалося оновити дані', oldStatus: currentStatus)),
      (status) => emit(PrinterLoaded(status)),
    );
  }
}