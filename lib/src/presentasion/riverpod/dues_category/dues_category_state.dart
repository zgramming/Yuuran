part of 'dues_category_notifier.dart';

class DuesCategoryState extends Equatable {
  const DuesCategoryState({
    this.items = const [],
    this.item,
    this.isError = false,
    this.message,
  });

  final List<DuesCategoryModel> items;
  final DuesCategoryModel? item;
  final bool isError;
  final String? message;

  DuesCategoryState init({
    bool isError = false,
    String? message,
    List<DuesCategoryModel> items = const [],
    DuesCategoryModel? item,
  }) {
    return copyWith(
      isError: isError,
      items: items,
      message: message,
      item: item,
    );
  }

  @override
  List<Object?> get props => [items, item, isError, message];

  @override
  String toString() {
    return 'DuesCategoryState(items: $items, item: $item, isError: $isError, message: $message)';
  }

  DuesCategoryState copyWith({
    List<DuesCategoryModel>? items,
    DuesCategoryModel? item,
    bool? isError,
    String? message,
  }) {
    return DuesCategoryState(
      items: items ?? this.items,
      item: item ?? this.item,
      isError: isError ?? this.isError,
      message: message ?? this.message,
    );
  }
}
