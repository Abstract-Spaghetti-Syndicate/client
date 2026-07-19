import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/filament_repository.dart';
import 'filament_event.dart';
import 'filament_state.dart';

class FilamentBloc extends Bloc<FilamentEvent, FilamentState> {
  final FilamentRepository _repository;

  FilamentBloc(this._repository) : super(FilamentInitial()) {
    on<FetchFilaments>(_onFetchFilaments);
  }

  Future<void> _onFetchFilaments(
    FetchFilaments event,
    Emitter<FilamentState> emit,
  ) async {
    emit(FilamentLoading());
    
    final result = await _repository.getSpools();
    
    result.fold(
      (failure) => emit(FilamentError(failure.message)),
      (spools) => emit(FilamentLoaded(spools)),
    );
  }
}