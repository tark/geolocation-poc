import 'dart:async';

import 'package:dio/dio.dart';
import '../util/log.dart';
import 'main_interceptor.dart';

class Api {
  Api() {
    _dio = Dio();
    _dio?.interceptors.add(
      MainInterceptor(),
    );
  }

  Dio? _dio;

  //
  Future<dynamic> _get(
    String path, {
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    try {
      final dio = _dio;
      if (dio == null) {
        return {};
      }

      final response = await dio.get(
        '/$path',
        queryParameters: query,
        options: options ??
            Options(
              headers: {
                'accept': 'application/json',
              },
            ),
      );
      return response.data;
    } on DioError catch (e) {
      l('_get', '---------------------------------');
      l('_get', 'error - error:    ${e.error}');
      l('_get', 'error - type:     ${e.error.runtimeType}');
      l('_get', 'error - type dio: ${e.type}');
      l('_get', '---------------------------------');
      throw e.message;
    }
  }

  Future<Map<String, dynamic>?> _post(
    String path, {
    Map<String, dynamic>? body,
    Options? options,
  }) async {
    try {
      final dio = _dio;
      if (dio == null) {
        return {};
      }

      final response = await dio.post(
        '/$path',
        data: body,
        options: options ??
            Options(
              headers: {
                'accept': 'application/json',
                'Content-Type': 'application/json',
              },
            ),
      );

      if (response.statusCode == 204) {
        return {};
      }

      if (response.data == '' && response.statusCode == 200) {
        return {};
      }

      return response.data ?? {};
    } on DioError catch (e) {

      l('_post', 'data:             ${e.response?.data.toString()}');
      l('_post', 'message:          ${e.message}');
      if (e.response?.data is String) {
        throw e.message;
      } else {
        throw e.response?.data['errorMsg'] ?? e.message;
      }
    }
  }

  Future<Map<String, dynamic>> _delete(String path) async {
    try {
      final dio = _dio;
      if (dio == null) {
        return {};
      }

      final response = await dio.delete(
        '/$path',
      );
      l('_delete', response);
      return response.data ?? {};
    } on DioError catch (e) {

      l('_delete', 'dio error - ${e.message}');
      throw e.message;
    }
  }

  Future<Map<String, dynamic>> _put(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final dio = _dio;
      if (dio == null) {
return {};
          }

      final response = await dio.put(
        '/$path',
        data: body,
      );
      return response.data ?? {};
    } on DioError catch (e) {
      l('_put', 'dio error - ${e.message}');
      throw e.message;
    }
  }

  Future<Map<String, dynamic>> _patch(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final dio = _dio;
      final response = await dio?.patch(
        '/$path',
        data: body,
      );
      return response?.data;
    } on DioError catch (e) {
      l('_patch', 'dio error - ${e.message}');
      throw e.message;
    }
  }
}
