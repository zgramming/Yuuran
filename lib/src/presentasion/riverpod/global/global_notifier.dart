import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/dues_calendar_parameter.dart';
import '../../../data/model/dues_parameter.dart';

final duesParameter = StateProvider(
  (ref) => DuesParameter(
    month: DateTime.now().month,
    year: DateTime.now().year,
  ),
);

final duesCalendarParameter = StateProvider(
  (ref) {
    final now = DateTime.now();
    return DuesCalendarParameter(
      focusedDay: DateTime.utc(now.year, now.month, now.day),
      selectedDay: DateTime.utc(now.year, now.month, now.day),
    );
  },
);
