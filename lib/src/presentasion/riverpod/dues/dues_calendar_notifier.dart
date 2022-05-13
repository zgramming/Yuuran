import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../parameter/parameter_notifier.dart';

final getDuesCalendarActivity = FutureProvider.autoDispose((ref) async {
  final repository = ref.watch(duesRepository);
  final month = ref.watch(duesCalendarParameter.select((value) => value.focusedDay.month));
  final year = ref.watch(duesCalendarParameter.select((value) => value.focusedDay.year));
  final result = await repository.getCalendarActivity(month: month, year: year);
  return result.fold((failure) => throw Exception(failure.message), (items) => items);
});

final duesCalendarByDate = Provider.autoDispose((ref) {
  final selectedDay = ref.watch(duesCalendarParameter.select((value) => value.selectedDay));
  final calendarActivity = ref.watch(getDuesCalendarActivity).value ?? {};
  return calendarActivity[selectedDay] ?? [];
});
