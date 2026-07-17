// lib/features/auth/presentation/bloc/auth_state.dart
import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

/// Стан ініціалізації (Splash Screen) — читаємо диск у пошуках токена
class AuthInitializing extends AuthState {}

/// Стан, коли користувач неавторизований (показуємо форму логіну)
class Unauthenticated extends AuthState {
  final String? errorMessage;

  const Unauthenticated({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

/// Стан автентифікації в процесі (блокуємо інтерфейс, показуємо лоадер)
class AuthLoading extends AuthState {}

/// Успішна авторизація (переходимо на Dashboard принтерів)
class Authenticated extends AuthState {
  final String token;

  const Authenticated({required this.token});

  @override
  List<Object?> get props => [token];
}