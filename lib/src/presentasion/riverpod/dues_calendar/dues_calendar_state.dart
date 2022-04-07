part of 'dues_calendar_notifier.dart';

class DuesCalendarState extends Equatable {
  const DuesCalendarState({
    this.maps = const {},
    this.isError = false,
    this.message,
  });

  final Map<DateTime, List<DuesDetailModel>> maps;
  final bool isError;
  final String? message;

  DuesCalendarState init({
    List<DuesDetailModel> items = const [],
    bool isError = false,
    String? message,
  }) {
    final myCalendar = LinkedHashMap<DateTime, List<DuesDetailModel>>(
      equals: isSameDay,
      hashCode: (date) => date.day * 1000000 + date.month * 10000 + date.year,
    );

    for (var item in items) {
      final date = DateTime.utc(
        item.createdAt!.year,
        item.createdAt!.month,
        item.createdAt!.day,
      );
      final isExist = myCalendar[date];
      if (isExist == null) myCalendar[date] = [];

      myCalendar[date]?.add(item);
    }

    return copyWith(
      isError: isError,
      maps: myCalendar,
      message: message,
    );
  }

  @override
  List<Object?> get props => [maps, isError, message];

  @override
  String toString() => 'DuesCalendarState(maps: $maps, isError: $isError, message: $message)';

  DuesCalendarState copyWith({
    Map<DateTime, List<DuesDetailModel>>? maps,
    bool? isError,
    String? message,
  }) {
    return DuesCalendarState(
      maps: maps ?? this.maps,
      isError: isError ?? this.isError,
      message: message ?? this.message,
    );
  }
}
