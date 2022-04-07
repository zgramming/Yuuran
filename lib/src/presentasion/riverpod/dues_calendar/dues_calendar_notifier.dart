import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../injection.dart';
import '../../../data/model/dues_detail/dues_detail_model.dart';
import '../../../domain/repository/dues_calendar_repository.dart';
import '../global/global_notifier.dart';

part 'dues_calendar_state.dart';

class DuesCalendarNotifier extends StateNotifier<DuesCalendarState> {
  DuesCalendarNotifier({
    required this.repository,
  }) : super(const DuesCalendarState());

  final DuesCalendarRepository repository;

  Future<DuesCalendarState> get({
    int? month,
    int? year,
  }) async {
    final result = await repository.get(
      month: month,
      year: year,
    );

    return result.fold(
      (failure) => state = state.init(isError: true, items: [], message: failure.message),
      (items) => state = state.init(
        isError: false,
        items: items,
        message: null,
      ),
    );
  }
}

final getDuesCalendar = FutureProvider.autoDispose((ref) async {
  final notifier = ref.watch(duesCalendarNotifier.notifier);
  final month = ref.watch(duesCalendarParameter.select((value) => value.focusedDay.month));
  final year = ref.watch(duesCalendarParameter.select((value) => value.focusedDay.year));
  final result = await notifier.get(month: month, year: year);
  return result;
});

final duesCalendarByDate = Provider((ref) {
  final selectedDay = ref.watch(duesCalendarParameter.select((value) => value.selectedDay));
  final maps = ref.watch(duesCalendarNotifier).maps[selectedDay] ?? [];
  return maps;
});
