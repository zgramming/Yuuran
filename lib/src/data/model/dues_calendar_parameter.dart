import 'package:equatable/equatable.dart';

class DuesCalendarParameter extends Equatable {
  const DuesCalendarParameter({
    required this.focusedDate,
    required this.selectedDate,
  });

  final DateTime focusedDate;
  final DateTime selectedDate;

  @override
  List<Object> get props => [focusedDate, selectedDate];

  @override
  String toString() =>
      'DuesCalendarParameter(focusedDate: $focusedDate, selectedDate: $selectedDate)';

  DuesCalendarParameter copyWith({
    DateTime? focusedDate,
    DateTime? selectedDate,
  }) {
    return DuesCalendarParameter(
      focusedDate: focusedDate ?? this.focusedDate,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
