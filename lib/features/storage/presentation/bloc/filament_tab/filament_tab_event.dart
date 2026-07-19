import 'package:equatable/equatable.dart';

abstract class FilamentTabEvent extends Equatable {
  const FilamentTabEvent();
  @override
  List<Object> get props => [];
}

class FetchFilamentsTab extends FilamentTabEvent {}