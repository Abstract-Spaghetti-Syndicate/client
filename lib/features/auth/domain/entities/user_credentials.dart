// lib/features/auth/domain/entities/user_credentials.dart
class UserCredentials {
  final String serverUrl;
  final String email;
  final String password;

  const UserCredentials({
    required this.serverUrl,
    required this.email,
    required this.password,
  });
}