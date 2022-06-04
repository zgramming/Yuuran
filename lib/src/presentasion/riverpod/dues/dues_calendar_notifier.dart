import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../parameter/dues_calendar_parameter.dart';

final getDuesCalendarActivity = FutureProvider.autoDispose((ref) async {
  final repository = ref.watch(duesRepository);
  final focusedDate = ref.watch(duesCalendarParameter.select((value) => value.focusedDate));
  final result =
      await repository.getCalendarActivity(month: focusedDate.month, year: focusedDate.year);
  return result.fold((failure) => throw Exception(failure.message), (items) => items);
});

final duesCalendarByDate = Provider.autoDispose((ref) {
  final selectedDate = ref.watch(duesCalendarParameter.select((value) => value.selectedDate));
  final calendarActivity = ref.watch(getDuesCalendarActivity).value ?? {};
  return calendarActivity[selectedDate] ?? [];
});
