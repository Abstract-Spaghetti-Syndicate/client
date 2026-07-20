import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printer_client/core/usecases/usecase.dart'; // Переконайся, що імпорт є
import 'package:printer_client/features/printer/domain/entities/printer_status.dart';
import '../../domain/usecases/get_printer_status.dart';
import 'printer_event.dart';
import 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  final GetPrinterStatus getPrinterStatus;

  PrinterBloc({required this.getPrinterStatus}) : super(PrinterInitial()) {
    on<FetchPrinterStatus>((event, emit) async {
      emit(const PrinterLoading());
      
      // 🌟 ВИПРАВЛЕНО: Замість null передаємо NoParams()
      final failureOrStatus = await getPrinterStatus(NoParams());
      
      failureOrStatus.fold(
        (failure) => emit(PrinterError(failure.message)),
        (status) => emit(PrinterLoaded(status as PrinterStatus)),
      );
    });
  }
}