// lib/features/auth/data/models/auth_response_model.dart
class AuthResponseModel {
  final String token;
  final String userEmail;

  const AuthResponseModel({required this.token, required this.userEmail});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['token'] as String,
      userEmail: json['user_email'] as String,
    );
  }
}