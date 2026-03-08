import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/app_constants.dart';
import 'auth_interceptor.dart';      
import 'error_interceptor.dart';    
import 'logging_interceptor.dart';  

part 'dio_client.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept':        'application/json',
      },
    ),
  );

  dio.interceptors.addAll([
    AuthInterceptor(),
    ErrorInterceptor(),
    if (kDebugMode) LoggingInterceptor(),
  ]);

  return dio;
}