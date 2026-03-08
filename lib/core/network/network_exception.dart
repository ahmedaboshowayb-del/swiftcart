sealed class NetworkException implements Exception {
  const NetworkException(this.message);
  final String message;

  const factory NetworkException.timeout(String message)      = TimeoutException;
  const factory NetworkException.noInternet(String message)   = NoInternetException;
  const factory NetworkException.unauthorized(String message) = UnauthorizedException;
  const factory NetworkException.forbidden(String message)    = ForbiddenException;
  const factory NetworkException.notFound(String message)     = NotFoundException;
  const factory NetworkException.badRequest(String message)   = BadRequestException;
  const factory NetworkException.validation(String message)   = ValidationException;
  const factory NetworkException.server(String message)       = ServerException;
  const factory NetworkException.unknown(String message)      = UnknownException;
}

final class TimeoutException       extends NetworkException { const TimeoutException(super.m); }
final class NoInternetException    extends NetworkException { const NoInternetException(super.m); }
final class UnauthorizedException  extends NetworkException { const UnauthorizedException(super.m); }
final class ForbiddenException     extends NetworkException { const ForbiddenException(super.m); }
final class NotFoundException      extends NetworkException { const NotFoundException(super.m); }
final class BadRequestException    extends NetworkException { const BadRequestException(super.m); }
final class ValidationException    extends NetworkException { const ValidationException(super.m); }
final class ServerException        extends NetworkException { const ServerException(super.m); }
final class UnknownException       extends NetworkException { const UnknownException(super.m); }