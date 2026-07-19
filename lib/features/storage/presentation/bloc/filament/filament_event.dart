import 'package:equatable/equatable.dart';

abstract class FilamentEvent extends Equatable {
  const FilamentEvent();

  @override
  List<Object> get props => [];
}

// Подія для запиту списку котушок
class FetchFilaments extends FilamentEvent {}