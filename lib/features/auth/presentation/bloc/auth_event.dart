// lib/features/auth/presentation/bloc/auth_event.dart
import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Подія старту додатка — перевірка наявності активної сесії
class AppStarted extends AuthEvent {}

/// Подія спроби входу користувача
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Подія виходу з системи або інвалідації токена (401 Error)
class LogoutRequested extends AuthEvent {}