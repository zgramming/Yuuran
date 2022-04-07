part of 'dues_recent_activity_notifier.dart';

class DuesRecentActivityState extends Equatable {
  const DuesRecentActivityState({
    this.items = const [],
    this.isError = false,
    this.message,
  });

  final List<DuesDetailModel> items;
  final bool isError;
  final String? message;

  DuesRecentActivityState init({
    List<DuesDetailModel> items = const [],
    bool isError = false,
    String? message,
  }) {
    return copyWith(
      items: items,
      isError: isError,
      message: message,
    );
  }

  @override
  List<Object?> get props => [items, isError, message];

  @override
  String toString() =>
      'DuesRecentActivityState(items: $items, isError: $isError, message: $message)';

  DuesRecentActivityState copyWith({
    List<DuesDetailModel>? items,
    bool? isError,
    String? message,
  }) {
    return DuesRecentActivityState(
      items: items ?? this.items,
      isError: isError ?? this.isError,
      message: message ?? this.message,
    );
  }
}
