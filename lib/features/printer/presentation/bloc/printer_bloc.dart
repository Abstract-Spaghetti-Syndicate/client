// lib/features/printer/presentation/bloc/printer_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_printer_status.dart';
import 'package:printer_client/core/usecases/usecase.dart';
import 'printer_event.dart';
import 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  final GetPrinterStatus getPrinterStatus;

  PrinterBloc({required this.getPrinterStatus}) : super(PrinterInitial()) {
    on<FetchPrinterStatus>((event, emit) async {
      emit(PrinterLoading());
      final failureOrStatus = await getPrinterStatus(NoParams());
      
      failureOrStatus.fold(
        (failure) => emit(PrinterError(message: failure.toString())),
        (status) => emit(PrinterLoaded(status: status)),
      );
    });
  }
}