import 'package:equatable/equatable.dart';

class DuesCalendarParameter extends Equatable {
  const DuesCalendarParameter({
    required this.focusedDay,
    required this.selectedDay,
  });

  final DateTime focusedDay;
  final DateTime selectedDay;

  @override
  List<Object> get props => [focusedDay, selectedDay];

  @override
  String toString() => 'DuesCalendarParameter(focusedDay: $focusedDay, selectedDay: $selectedDay)';

  DuesCalendarParameter copyWith({
    DateTime? focusedDay,
    DateTime? selectedDay,
  }) {
    return DuesCalendarParameter(
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}
