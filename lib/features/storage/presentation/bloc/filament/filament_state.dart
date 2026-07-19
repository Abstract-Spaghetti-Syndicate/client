import 'package:equatable/equatable.dart';
import '../../../domain/entities/spool.dart';

abstract class FilamentState extends Equatable {
  const FilamentState();
  
  @override
  List<Object?> get props => [];
}

class FilamentInitial extends FilamentState {}

class FilamentLoading extends FilamentState {}

class FilamentLoaded extends FilamentState {
  final List<Spool> spools;

  const FilamentLoaded(this.spools);

  @override
  List<Object?> get props => [spools];
}

class FilamentError extends FilamentState {
  final String message;

  const FilamentError(this.message);

  @override
  List<Object?> get props => [message];
}