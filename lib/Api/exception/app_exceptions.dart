

import 'package:dio/dio.dart';

class DeadLineExceededException extends DioError {
  DeadLineExceededException(
      {required super.requestOptions, required super.response});

  @override
  String toString() {
    return 'Request Timeout';
  }
}

class BadRequestException extends DioError {
  BadRequestException({required super.requestOptions, required super.response});

  @override
  String toString() {
    late String msg;
    List<dynamic> errorList;
    if (response == null) {
      msg = "Oops! Something went wrong with your request.";
    }
    if (response?.data is String) {
      msg = response?.data;
      return msg;
    }

    if (response?.data is List) {
      errorList = response?.data as List<dynamic>;

      if (errorList.isEmpty) return msg;

      if (errorList.length > 1) {
        msg = errorList.join("\n");
      } else {
        msg = errorList.first;
      }
    }

    return msg;
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException({
    required super.requestOptions,
    required super.response,
  });

  @override
  String toString() {
    return "Unauthorized User";
  }
}

class NotFoundException extends DioError {
  NotFoundException({required super.requestOptions, required super.response});

  @override
  String toString() {
    return "Not found";
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(
      {required super.requestOptions, required super.response});

  @override
  String toString() {
    return "Internal server error";
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(
      {required super.requestOptions, required super.response});

  @override
  String toString() {
    return 'No internet connection';
  }
}

class OtpRequiredException implements Exception {
  @override
  String toString() {
    return 'Token has been expired, please provide otp';
  }
}
