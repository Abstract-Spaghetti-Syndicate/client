import 'package:equatable/equatable.dart';
import '../../../domain/entities/filament.dart';

abstract class FilamentTabState extends Equatable {
  const FilamentTabState();
  @override
  List<Object?> get props => [];
}

class FilamentTabInitial extends FilamentTabState {}
class FilamentTabLoading extends FilamentTabState {}
class FilamentTabLoaded extends FilamentTabState {
  final List<FilamentEntity> filaments;
  const FilamentTabLoaded(this.filaments);
  @override
  List<Object?> get props => [filaments];
}
class FilamentTabError extends FilamentTabState {
  final String message;
  const FilamentTabError(this.message);
  @override
  List<Object?> get props => [message];
}