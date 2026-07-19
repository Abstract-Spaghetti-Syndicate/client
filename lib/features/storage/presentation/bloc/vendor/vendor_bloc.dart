import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/vendor_repository.dart';
import 'vendor_event.dart';
import 'vendor_state.dart';

class VendorBloc extends Bloc<VendorEvent, VendorState> {
  final VendorRepository _repository;

  VendorBloc(this._repository) : super(VendorInitial()) {
    on<FetchVendors>(_onFetchVendors);
  }

  Future<void> _onFetchVendors(FetchVendors event, Emitter<VendorState> emit) async {
    emit(VendorLoading());
    final result = await _repository.getVendors();
    result.fold(
      (failure) => emit(VendorError(failure.message)),
      (vendors) => emit(VendorLoaded(vendors)),
    );
  }
}