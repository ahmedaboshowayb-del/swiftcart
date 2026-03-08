import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure(this.message, {this.code});

  final String message;
  final String? code;

  String get userMessage => switch (this) {
    NetworkFailure()    => 'No internet connection. Please try again.',
    ServerFailure()     => 'Something went wrong on our end. Try again later.',
    AuthFailure()       => message,           
    CacheFailure()      => 'Failed to load local data. Please refresh.',
    ValidationFailure() => message,          
    NotFoundFailure()   => 'The requested item was not found.',
    UnknownFailure()    => 'An unexpected error occurred.',
  };

  @override
  List<Object?> get props => [message, code];
}

final class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.code});
}

final class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code});
}

final class AuthFailure extends Failure {
  const AuthFailure(super.message, {super.code});
}

final class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.code});
}

final class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.code});
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, {super.code});
}

final class UnknownFailure extends Failure {
  const UnknownFailure(super.message, {super.code});
}