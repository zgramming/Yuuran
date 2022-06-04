import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/dues_calendar_parameter.dart';

final duesCalendarParameter = StateProvider.autoDispose(
  (ref) {
    final now = DateTime.now();
    return DuesCalendarParameter(
      focusedDate: DateTime.utc(now.year, now.month, now.day),
      selectedDate: DateTime.utc(now.year, now.month, now.day),
    );
  },
);
