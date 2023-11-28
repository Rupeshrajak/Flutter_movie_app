import 'dart:core';
import 'package:dio/dio.dart';
import '../api/app_interceptor.dart';

import 'api_url.dart';

class ApiClient {
  final _dio = createDio(baseUrl: ApiUrl.baseUrl);

  ApiClient._internal();

  static final _singleton = ApiClient._internal();

  factory ApiClient() => _singleton;

  /// This method is used to get movie list details
  Future<Response> getNowPlayingMovieDetails() async {
    Response response = await _dio.get(ApiUrl.nowPlayingApi);
    return response;
  }

  /// This method is used to get movie list details
  Future<Response> getTopRatedMovieDetails() async {
    Response response = await _dio.get(ApiUrl.topRatedMovieApi);
    return response;
  }

  // Method to create instance of Dio
  static Dio createDio({required String baseUrl}) {
    var dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: 30000, // 30 seconds
      connectTimeout: 30000,
      sendTimeout: 30000,
    ));
    dio.interceptors.clear();
    dio.interceptors.addAll({
      AppInterceptor(dio),
    });
    return dio;
  }
}
