import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/dues_calendar_parameter.dart';
import '../../../data/model/dues_citizen_parameter.dart';
import '../../../data/model/dues_parameter.dart';

final selectedYearMonthParameter = StateProvider.autoDispose(
  (ref) => SelectedMonthYearParameter(month: DateTime.now().month, year: DateTime.now().year),
);

final duesCalendarParameter = StateProvider.autoDispose(
  (ref) {
    final now = DateTime.now();
    return DuesCalendarParameter(
      focusedDay: DateTime.utc(now.year, now.month, now.day),
      selectedDay: DateTime.utc(now.year, now.month, now.day),
    );
  },
);

final duesCitizenParameter = StateProvider.autoDispose((ref) {
  final now = DateTime.now();
  return DuesCitizenParameter(month: now.month, year: now.year);
});
