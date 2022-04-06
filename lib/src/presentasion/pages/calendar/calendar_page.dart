import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../main.dart';
import '../../../utils/utils.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  final kEvents = LinkedHashMap<DateTime, List<MyEvent>>(
    equals: isSameDay,
    hashCode: (date) => date.day * 1000000 + date.month * 10000 + date.year,
  );

  final _myEvents = LinkedHashMap<DateTime, List<MyEvent>>(
    equals: isSameDay,
    hashCode: (date) => date.day * 1000000 + date.month * 10000 + date.year,
  );

  @override
  void initState() {
    super.initState();
    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    final _eventSource = {
      for (var item in List.generate(10, (index) => index))
        DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5):
            List.generate(item % 4 + 1, (index) => MyEvent(title: 'Event $item | ${index + 1}'))
    }..addAll({
        kToday: const [
          MyEvent(title: "Event 1"),
          MyEvent(title: "Event 2"),
        ]
      });

    _myEvents.addAll(_eventSource);
  }

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
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: TableCalendar(
                headerStyle: calendarHeaderStyle,
                focusedDay: _focusedDay,
                daysOfWeekStyle: daysOfWeekStyle,
                locale: 'id_ID',
                firstDay: DateTime.utc(DateTime.now().year - 10),
                lastDay: DateTime.utc(DateTime.now().year + 10),
                availableGestures: AvailableGestures.horizontalSwipe,
                eventLoader: (date) => _myEvents[date] ?? [],
                calendarStyle: const CalendarStyle(
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
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
            const SizedBox(height: 32.0),
            ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
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
                          index.isOdd ? "IURAN KEAMANAN (IRKM)" : "IURAN KEBERSIHAN (IRKB)",
                          style: hFontWhite,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Zeffry Reynando",
                          style: hFont.copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Update terakhir ${GlobalFunction.formatYMDHM(DateTime.now())}",
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
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
