import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils/utils.dart';
import '../../riverpod/dues_calendar/dues_calendar_notifier.dart';
import '../../riverpod/global/global_notifier.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // DateTime _focusedDay = DateTime.now();
  // DateTime _selectedDay = DateTime.now();

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

  final availableCalendarFormats = const {CalendarFormat.month: 'month'};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 32.0,
        ),
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final _myCalendar = ref.watch(getDuesCalendar);
                return _myCalendar.when(
                  data: (data) {
                    final _calendarParam = ref.watch(duesCalendarParameter);

                    return Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      child: TableCalendar(
                        headerStyle: calendarHeaderStyle,
                        focusedDay: _calendarParam.focusedDay,
                        daysOfWeekStyle: daysOfWeekStyle,
                        locale: 'id_ID',
                        firstDay: DateTime.utc(DateTime.now().year - 10),
                        lastDay: DateTime.utc(DateTime.now().year + 10),
                        availableGestures: AvailableGestures.horizontalSwipe,
                        eventLoader: (date) {
                          return data.maps[date] ?? [];
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
                                child: Text(
                                  "${events.length} Iuran",
                                  style: bFontWhite.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0,
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
                          return isSameDay(_calendarParam.selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(_calendarParam.selectedDay, selectedDay)) {
                            // Call `setState()` when updating the selected day
                            ref
                                .read(duesCalendarParameter.notifier)
                                .update((state) => state.copyWith(selectedDay: selectedDay));
                          }
                        },
                        onPageChanged: (focusedDay) {
                          ref
                              .read(duesCalendarParameter.notifier)
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
            const SizedBox(height: 32.0),
            Consumer(
              builder: (context, ref, child) {
                final items = ref.watch(duesCalendarByDate);
                return ListView.builder(
                  itemCount: items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final item = items[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: index.isEven ? warning : secondary,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                            ),
                            child: Text(
                              "${item.duesCategory?.name} (${item.duesCategory?.code})",
                              style: hFontWhite,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "${item.user?.name}",
                              style: hFont.copyWith(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text.rich(
                                TextSpan(
                                  text: "Iuran untuk bulan ",
                                  children: [
                                    TextSpan(
                                      text: sharedFunction.monthString(item.month) +
                                          " " +
                                          item.year.toString(),
                                      style: bFont.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                style: bFont.copyWith(
                                  color: grey,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            trailing: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  GlobalFunction.formatNumber(index.isOdd ? 25000 : 10000),
                                  style: bFont.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
