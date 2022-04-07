part of 'dues_category_notifier.dart';

class DuesCategoryState extends Equatable {
  const DuesCategoryState({
    this.items = const [],
    this.isError = false,
    this.message,
  });

  final List<DuesCategoryModel> items;
  final bool isError;
  final String? message;

  DuesCategoryState init({
    bool isError = false,
    String? message,
    List<DuesCategoryModel> items = const [],
  }) {
    return copyWith(isError: isError, items: items, message: message);
  }

  @override
  List<Object?> get props => [items, isError, message];

  @override
  String toString() => 'DuesCategoryState(items: $items, isError: $isError, message: $message)';

  DuesCategoryState copyWith({
    List<DuesCategoryModel>? items,
    bool? isError,
    String? message,
  }) {
    return DuesCategoryState(
      items: items ?? this.items,
      isError: isError ?? this.isError,
      message: message ?? this.message,
    );
  }
}
