import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/filament_entity.dart';
import '../../../domain/usecases/watch_filaments.dart';
import '../../../domain/usecases/add_filament.dart';

part 'filament_event.dart';
part 'filament_state.dart';

class FilamentBloc extends Bloc<FilamentEvent, FilamentState> {
  final WatchFilaments watchFilaments;
  final AddFilament addFilament;
  StreamSubscription<List<FilamentEntity>>? _filamentsSubscription;

  FilamentBloc({
    required this.watchFilaments,
    required this.addFilament,
  }) : super(FilamentInitial()) {
    on<SubscriptionRequested>(_onSubscriptionRequested);
    on<FilamentAdded>(_onFilamentAdded);
    on<_FilamentsUpdated>(_onFilamentsUpdated);
  }

  Future<void> _onSubscriptionRequested(
    SubscriptionRequested event,
    Emitter<FilamentState> emit, // 🌟 ВИПРАВЛЕНО: Emitter замість Emit
  ) async {
    emit(FilamentLoading());
    await _filamentsSubscription?.cancel();

    _filamentsSubscription = watchFilaments().listen(
      (filaments) => add(_FilamentsUpdated(filaments)),
      onError: (error) => emit(FilamentError(message: error.toString())),
    );
  }

  void _onFilamentsUpdated(
    _FilamentsUpdated event,
    Emitter<FilamentState> emit,
  ) {
    emit(FilamentLoaded(event.filaments));
  }

  Future<void> _onFilamentAdded(
    FilamentAdded event,
    Emitter<FilamentState> emit,
  ) async {
    final result = await addFilament(event.filament);
    result.fold(
      (failure) => emit(FilamentError(message: failure.message)),
      (_) => null, // 🌟 Прибрано некоректний 'Right'
    );
  }

  @override
  Future<void> close() {
    _filamentsSubscription?.cancel();
    return super.close();
  }
}

// Внутрішній івент для реактивного оновлення
class _FilamentsUpdated extends FilamentEvent {
  final List<FilamentEntity> filaments;
  const _FilamentsUpdated(this.filaments);
  @override
  List<Object> get props => [filaments];
}