import 'package:dio/dio.dart';
import 'failure.dart';

class DioUtils {
  DioUtils._();
  static final instance = DioUtils._();

  Failure onError(DioError error) {
    final data = error.response?.data;
    switch (error.type) {
      case DioErrorType.response:
        return ResponseFailure(message: data['message']);
      case DioErrorType.connectTimeout:
        return const ConnectionTimeoutFailure();
      case DioErrorType.receiveTimeout:
        return const ReceiveTimeoutFailure();
      case DioErrorType.sendTimeout:
        return const SendTimeoutFailure();
      default:
        return const UncaughtFailure();
    }
  }
}

final dioUtils = DioUtils.instance;
