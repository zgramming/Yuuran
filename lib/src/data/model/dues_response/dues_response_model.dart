import 'package:equatable/equatable.dart';

class DuesResponse extends Equatable {
  const DuesResponse({
    this.message = '',
  });

  final String message;

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'DuesResponse(message: $message)';

  DuesResponse copyWith({
    String? message,
  }) {
    return DuesResponse(
      message: message ?? this.message,
    );
  }
}
