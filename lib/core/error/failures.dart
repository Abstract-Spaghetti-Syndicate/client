// lib/core/error/failures.dart
sealed class Failure {
  final String message;
  const Failure(this.message);
}

class InvalidUrlFailure extends Failure {
  const InvalidUrlFailure() : super('Введена некоректна адреса сервера.');
}

class ServerUnreachableFailure extends Failure {
  const ServerUnreachableFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}