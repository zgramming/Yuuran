part of 'dues_notifier.dart';

class DuesState extends Equatable {
  const DuesState({
    this.isError = false,
    this.message,
  });
  final bool isError;
  final String? message;

  DuesState init({
    required bool isError,
    required String message,
  }) {
    return copyWith(
      isError: isError,
      message: message,
    );
  }

  @override
  List<Object?> get props => [isError, message];

  @override
  String toString() => 'DuesState(isError: $isError, message: $message)';

  DuesState copyWith({
    bool? isError,
    String? message,
  }) {
    return DuesState(
      isError: isError ?? this.isError,
      message: message ?? this.message,
    );
  }
}
