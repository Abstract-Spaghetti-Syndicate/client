part of 'spool_bloc.dart';

abstract class SpoolState extends Equatable {
  const SpoolState();

  @override
  List<Object?> get props => [];
}

class SpoolInitial extends SpoolState {}