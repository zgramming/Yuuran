import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ResponseFailure extends Failure {
  const ResponseFailure({String message = "Response Failure"}) : super(message);
}

class ConnectionTimeoutFailure extends Failure {
  const ConnectionTimeoutFailure({String message = "Connection Timeout Failure"}) : super(message);
}

class SendTimeoutFailure extends Failure {
  const SendTimeoutFailure({String message = "Send Timeout Failure"}) : super(message);
}

class ReceiveTimeoutFailure extends Failure {
  const ReceiveTimeoutFailure({String message = "Receive Timeout Failure"}) : super(message);
}

class UncaughtFailure extends Failure {
  const UncaughtFailure({String message = "Uncaught Failure"}) : super(message);
}
