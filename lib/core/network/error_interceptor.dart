import 'package:dio/dio.dart';
import 'network_exception.dart';


class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final ex = switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout    ||
      DioExceptionType.receiveTimeout =>
          NetworkException.timeout('Request timed out'),

      DioExceptionType.badResponse =>
          _fromStatusCode(
            err.response?.statusCode,
            err.response?.data,
          ),

      DioExceptionType.connectionError =>
          const NetworkException.noInternet('No internet connection'),

      _ => NetworkException.unknown(err.message ?? 'Unknown error'),
    };

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: ex,
        message: ex.message,
      ),
    );
  }

  NetworkException _fromStatusCode(int? code, dynamic data) {
    final msg = _extractMessage(data);
    return switch (code) {
      400 => NetworkException.badRequest(msg ?? 'Bad request'),
      401 => NetworkException.unauthorized(msg ?? 'Unauthorized'),
      403 => NetworkException.forbidden(msg ?? 'Forbidden'),
      404 => NetworkException.notFound(msg ?? 'Resource not found'),
      422 => NetworkException.validation(msg ?? 'Validation error'),
      500 || 502 || 503 => NetworkException.server(msg ?? 'Server error'),
      _ => NetworkException.unknown(msg ?? 'HTTP $code'),
    };
  }

  String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ?? data['error'] as String?;
    }
    return null;
  }
}