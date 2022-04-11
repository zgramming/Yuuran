part of 'dues_statistics_notifier.dart';

class DuesStatisticsState extends Equatable {
  const DuesStatisticsState({
    this.item = const DuesStatisticsModel(),
    this.isError = false,
    this.message,
  });

  final DuesStatisticsModel item;
  final bool isError;
  final String? message;

  DuesStatisticsState init({
    DuesStatisticsModel? value,
    bool isError = false,
    String? message,
  }) {
    return copyWith(
      item: value,
      isError: isError,
      message: message,
    );
  }

  int sumDuesByCategories(int duesCategoryId) {
    final category = item.duesCategory.firstWhere((element) => element.id == duesCategoryId);
    return category.duesDetail
        .map((e) => e.amount)
        .fold(0, (previousValue, element) => previousValue + element);
  }

  @override
  List<Object?> get props => [item, isError, message];

  @override
  String toString() => 'DuesStatisticsState(item: $item, isError: $isError, message: $message)';

  DuesStatisticsState copyWith({
    DuesStatisticsModel? item,
    bool? isError,
    String? message,
  }) {
    return DuesStatisticsState(
      item: item ?? this.item,
      isError: isError ?? this.isError,
      message: message ?? this.message,
    );
  }
}
