import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/location_repository.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _repository;

  LocationBloc(this._repository) : super(LocationInitial()) {
    on<FetchLocations>(_onFetchLocations);
  }

  Future<void> _onFetchLocations(FetchLocations event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    final result = await _repository.getLocations();
    result.fold(
      (failure) => emit(LocationError(failure.message)),
      (locations) => emit(LocationLoaded(locations)),
    );
  }
}