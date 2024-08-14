import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/kdan_app_constant.dart';

final taskDioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  return TaskDio(dio).dio;
});

class TaskDio {
  final Dio dio;


  TaskDio(this.dio) {
    dio.options = dioBaseOptions;
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }
    // TODO : could add interceptor
    //dio.interceptors.add();
  }

  BaseOptions get dioBaseOptions => BaseOptions(
    baseUrl: baseUrl,
    headers: headers,
    receiveTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
    connectTimeout: const Duration(seconds: 10),
  );

  Map<String, Object> get headers => {
    'accept': 'application/json',
    'Content-Type': 'application/json',
  };

  String get baseUrl => KDanAppConstants.baseUrl;
}
