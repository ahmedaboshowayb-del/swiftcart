import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor extends Interceptor {
  final _log = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _log.i(
      '→ ${options.method} ${options.uri}\n'
      'Headers: ${_sanitiseHeaders(options.headers)}\n'
      'Data: ${_truncate(options.data.toString())}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _log.d(
      '← ${response.statusCode} ${response.requestOptions.uri}\n'
      'Data: ${_truncate(response.data.toString())}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log.e(
      '✗ ${err.requestOptions.method} ${err.requestOptions.uri}\n'
      'Status: ${err.response?.statusCode}\n'
      'Message: ${err.message}',
    );
    handler.next(err);
  }

  Map<String, dynamic> _sanitiseHeaders(Map<String, dynamic> headers) {
    final copy = Map<String, dynamic>.from(headers);
    if (copy.containsKey('Authorization')) {
      copy['Authorization'] = 'Bearer [REDACTED]';
    }
    return copy;
  }

  String _truncate(String s, {int max = 500}) =>
      s.length <= max ? s : '${s.substring(0, max)}… [truncated]';
}