import 'dart:developer';

import 'package:dio/dio.dart';
import 'failure.dart';

class DioUtils {
  DioUtils._();
  static final instance = DioUtils._();

  Failure onError(DioError error) {
    final data = error.response?.data;
    switch (error.type) {
      case DioErrorType.response:
        log("Error DioResponse $data");
        return ResponseFailure(message: data is Map ? data['message'] : data);
      case DioErrorType.connectTimeout:
        log("Error DioConnectionTimeOut");
        return const ConnectionTimeoutFailure();
      case DioErrorType.receiveTimeout:
        log("Error DioReceiveTimeOut");
        return const ReceiveTimeoutFailure();
      case DioErrorType.sendTimeout:
        log("Error DioSendTimeOut");
        return const SendTimeoutFailure();
      default:
        log("Error DioUncaughtTimeOut");
        return const UncaughtFailure();
    }
  }
}

final dioUtils = DioUtils.instance;
