import 'package:equatable/equatable.dart';
import '../../../domain/entities/vendor_entity.dart';

abstract class VendorState extends Equatable {
  const VendorState();
  @override
  List<Object?> get props => [];
}

class VendorInitial extends VendorState {}
class VendorLoading extends VendorState {}
class VendorLoaded extends VendorState {
  final List<Vendor> vendors;
  const VendorLoaded(this.vendors);
  @override
  List<Object?> get props => [vendors];
}
class VendorError extends VendorState {
  final String message;
  const VendorError(this.message);
  @override
  List<Object?> get props => [message];
}