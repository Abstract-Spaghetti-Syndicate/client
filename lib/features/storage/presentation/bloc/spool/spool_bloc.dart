import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/repositories/spool_repository.dart';

part 'spool_event.dart';
part 'spool_state.dart';

class SpoolBloc extends Bloc<SpoolEvent, SpoolState> {
  final SpoolRepository spoolRepository;

  SpoolBloc({required this.spoolRepository}) : super(SpoolInitial()) {
    on<SpoolEvent>((event, emit) {
      // Обробник для майбутніх подій
    });
  }
}