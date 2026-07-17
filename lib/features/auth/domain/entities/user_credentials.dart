// lib/features/auth/domain/entities/user_credentials.dart
import 'package:equatable/equatable.dart';

class UserCredentials extends Equatable {
  final String email;
  final String password;

  // Прибрали const, тепер assert працює в Runtime під час створення об'єкта
  UserCredentials({
    required this.email,
    required this.password,
  }) {
    assert(email.contains('@'), 'Email must be valid');
    assert(password.length >= 6, 'Password too short');
  }

  @override
  List<Object?> get props => [email, password];
}