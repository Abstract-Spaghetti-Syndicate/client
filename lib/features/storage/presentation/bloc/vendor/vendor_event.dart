import 'package:equatable/equatable.dart';

abstract class VendorEvent extends Equatable {
  const VendorEvent();
  @override
  List<Object> get props => [];
}

class FetchVendors extends VendorEvent {}