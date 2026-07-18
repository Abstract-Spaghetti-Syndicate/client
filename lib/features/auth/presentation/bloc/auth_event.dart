// lib/features/auth/presentation/bloc/auth_event.dart
import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

/// Подія запиту автентифікації адміністратора
class SignInRequested extends AuthEvent {
  final String serverUrl;
  final String email;
  final String password;

  const SignInRequested({
    required this.serverUrl,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [serverUrl, email, password];
}

class LogoutRequested extends AuthEvent {}