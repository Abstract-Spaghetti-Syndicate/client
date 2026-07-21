import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message); // 🌟 Переведено на super-параметри
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class ServerUnreachableFailure extends Failure {
  const ServerUnreachableFailure([super.message = 'Сервер недоступний']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Невідома помилка']);
}

class InvalidUrlFailure extends Failure {
  const InvalidUrlFailure([super.message = 'Некоректний URL']);
}