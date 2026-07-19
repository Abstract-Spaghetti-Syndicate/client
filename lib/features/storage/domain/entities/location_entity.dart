import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final int id;
  final String name;
  final String? comment;

  const LocationEntity({
    required this.id,
    required this.name,
    this.comment,
  });

  @override
  List<Object?> get props => [id, name, comment];
}