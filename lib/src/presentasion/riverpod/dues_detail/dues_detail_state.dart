part of 'dues_detail_notifier.dart';

class DuesDetailState extends Equatable {
  const DuesDetailState({
    this.isError = false,
    this.message,
    this.item,
  });
  final bool isError;
  final String? message;
  final DuesDetailModel? item;

  DuesDetailState init({
    required bool isError,
    required String message,
    DuesDetailModel? item,
  }) {
    return copyWith(
      isError: isError,
      message: message,
      item: item,
    );
  }

  @override
  List<Object?> get props => [isError, message, item];

  @override
  String toString() => 'DuesDetailState(isError: $isError, message: $message, item: $item)';

  DuesDetailState copyWith({
    bool? isError,
    String? message,
    DuesDetailModel? item,
  }) {
    return DuesDetailState(
      isError: isError ?? this.isError,
      message: message ?? this.message,
      item: item ?? this.item,
    );
  }
}
