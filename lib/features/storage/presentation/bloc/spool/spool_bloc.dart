import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/spool_repository.dart';
import 'spool_event.dart';
import 'spool_state.dart';

class FilamentTabBloc extends Bloc<FilamentTabEvent, FilamentTabState> {
  final SpoolRepository _repository;

  FilamentTabBloc(this._repository) : super(FilamentTabInitial()) {
    on<FetchFilamentsTab>(_onFetchFilamentsTab);
  }

  Future<void> _onFetchFilamentsTab(
    FetchFilamentsTab event,
    Emitter<FilamentTabState> emit,
  ) async {
    emit(FilamentTabLoading());
    final result = await _repository.getFilaments();
    result.fold(
      (failure) => emit(FilamentTabError(failure.message)),
      (filaments) => emit(FilamentTabLoaded(filaments)),
    );
  }
}