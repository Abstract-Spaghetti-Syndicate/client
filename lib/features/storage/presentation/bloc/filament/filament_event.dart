part of 'filament_bloc.dart'; // 🌟 ЗВ'ЯЗОК З БЛОКОМ

abstract class FilamentEvent extends Equatable {
  const FilamentEvent();

  @override
  List<Object> get props => [];
}

class SubscriptionRequested extends FilamentEvent {}

class FilamentAdded extends FilamentEvent {
  final FilamentEntity filament;
  const FilamentAdded(this.filament);

  @override
  List<Object> get props => [filament];
}