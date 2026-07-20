part of 'filament_bloc.dart'; // 🌟 ЗВ'ЯЗОК З БЛОКОМ

abstract class FilamentState extends Equatable {
  const FilamentState();
  
  @override
  List<Object> get props => [];
}

class FilamentInitial extends FilamentState {}

class FilamentLoading extends FilamentState {}

class FilamentLoaded extends FilamentState {
  final List<FilamentEntity> filaments;
  const FilamentLoaded(this.filaments);

  @override
  List<Object> get props => [filaments];
}

class FilamentError extends FilamentState {
  final String message;
  const FilamentError({required this.message});

  @override
  List<Object> get props => [message];
}