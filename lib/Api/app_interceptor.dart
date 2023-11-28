import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'exception/app_exceptions.dart';

class AppInterceptor extends Interceptor {
  Dio dio;

  AppInterceptor(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {


    // Printing
    if (kDebugMode) {
      debugPrint("++++++++++++++++++++++++++++++++++++++++++++++");
      debugPrint("API URL: ${options.baseUrl}${options.path}");
      if (options.method == "GET") {
        debugPrint("API Request Query parameters: ${options.queryParameters}");
      } else {
        debugPrint("API Request: ${options.data}");
      }

      debugPrint("API Request Method: ${options.method}");
      debugPrint("API Request Header: ${options.headers}");
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      var encoder = const JsonEncoder.withIndent("   ");
      debugPrint("API Response: ${encoder.convert(response.data)}");
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint("API Error Data: ${err.response?.data}");
      debugPrint("API Error HTTP Code: ${err.response?.statusCode}");
    }
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadLineExceededException(
            requestOptions: err.requestOptions, response: err.response);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(
                requestOptions: err.requestOptions, response: err.response);
           case 401:
            debugPrint(
                "Request Option while getting 401: ${err.requestOptions.data}");
            debugPrint(
                "Error response while getting 401: ${err.response?.data}");
            throw UnauthorizedException(
                requestOptions: err.requestOptions, response: err.response);
          case 404:
            throw NotFoundException(
                requestOptions: err.requestOptions, response: err.response);
          case 500:
            throw InternalServerErrorException(
                requestOptions: err.requestOptions, response: err.response);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException(
            requestOptions: err.requestOptions, response: err.response);
    }
    super.onError(err, handler);
  }
}
