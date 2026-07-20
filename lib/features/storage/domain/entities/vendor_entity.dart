import 'package:equatable/equatable.dart';

class Vendor extends Equatable {
  final int id;
  final String name;
  final String? comment;

  const Vendor({
    required this.id,
    required this.name,
    this.comment,
  });

  @override
  List<Object?> get props => [id, name, comment];
}