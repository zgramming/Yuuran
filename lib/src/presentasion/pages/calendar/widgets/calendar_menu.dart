import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../utils/utils.dart';
import '../../../riverpod/dues/dues_calendar_notifier.dart';
import '../../../riverpod/parameter/parameter_notifier.dart';

class CalendarMenu extends StatelessWidget {
  const CalendarMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calendarHeaderStyle = HeaderStyle(
      decoration: const BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      headerMargin: const EdgeInsets.only(bottom: 24.0),
      titleCentered: true,
      titleTextStyle: hFontWhite.copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
      leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
      rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.white),
    );

    final daysOfWeekStyle = DaysOfWeekStyle(
      weekendStyle: hFont.copyWith(color: primary, fontWeight: FontWeight.bold),
      weekdayStyle: hFont.copyWith(),
    );

    const availableCalendarFormats = {CalendarFormat.month: 'month'};

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: sharedFunction.vh(context) / 2),
      child: Consumer(
        builder: (context, ref, child) {
          final future = ref.watch(getDuesCalendarActivity);
          return future.when(
            data: (activity) {
              final calendarParam = ref.watch(duesCalendarParameter);
              return Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: TableCalendar(
                  headerStyle: calendarHeaderStyle,
                  focusedDay: calendarParam.focusedDay,
                  daysOfWeekStyle: daysOfWeekStyle,
                  locale: 'id_ID',
                  firstDay: DateTime.utc(DateTime.now().year - 10),
                  lastDay: DateTime.utc(DateTime.now().year + 10),
                  availableGestures: AvailableGestures.horizontalSwipe,
                  eventLoader: (date) {
                    return activity[date] ?? [];
                  },
                  calendarStyle: const CalendarStyle(
                    /// Hidden Day when not current month
                    outsideDaysVisible: false,
                    todayDecoration: BoxDecoration(
                      color: primaryShade4,
                      shape: BoxShape.circle,
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      if (events.isEmpty) return null;
                      return Card(
                        color: secondary,
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text.rich(
                            TextSpan(
                              text: "${events.length} ",
                              children: [
                                TextSpan(
                                  text: "Aktifitas",
                                  style: bFontWhite.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 8.0,
                                  ),
                                ),
                              ],
                            ),
                            style: bFontWhite.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  availableCalendarFormats: availableCalendarFormats,
                  selectedDayPredicate: (day) {
                    // Use `selectedDayPredicate` to determine which day is currently selected.
                    // If this returns true, then `day` will be marked as selected.

                    // Using `isSameDay` is recommended to disregard
                    // the time-part of compared DateTime objects.
                    return isSameDay(calendarParam.selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(calendarParam.selectedDay, selectedDay)) {
                      // Call `setState()` when updating the selected day
                      ref
                          .watch(duesCalendarParameter.notifier)
                          .update((state) => state.copyWith(selectedDay: selectedDay));
                    }
                  },
                  onPageChanged: (focusedDay) {
                    ref
                        .watch(duesCalendarParameter.notifier)
                        .update((state) => state.copyWith(focusedDay: focusedDay));
                  },
                ),
              );
            },
            error: (error, trace) => Center(child: Text("Error $error")),
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
