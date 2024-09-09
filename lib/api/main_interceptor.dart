import 'dart:async';
import 'package:dio/dio.dart';

class ServerErrorStatus {
  static const unauthorized = 1;
  static const error = 2;
  static const exception = 3;
}

class Endpoint {
  static const login = 'login';
  static const register = 'register';
}

class MainInterceptor implements InterceptorsWrapper {
  static const _authorization = 'Authorization';

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // t('onRequest', '---------');
    // t('onRequest', '${options.method}: ${options.baseUrl}${options.path}');
    // t('onRequest', options.data);
    // t('onRequest', '---------');

    return handler.next(options);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final o = response.requestOptions;
    // s('onResponse - ---------');
    // s('onResponse - ${o.method}: ${o.baseUrl}${o.path}');
    // s('onResponse - $response');
    // s('onResponse - ---------');

    return handler.next(response);
  }

  @override
  Future onError(DioError error, ErrorInterceptorHandler handler) async {
    /*
    l('onError', '---------');
    l('onError', error.type);
    l('onError', error.stackTrace);
    l('onError', '---------');
    */
    return handler.next(error);
  }
}
