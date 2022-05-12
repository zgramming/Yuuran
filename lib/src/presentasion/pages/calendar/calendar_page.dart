import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../riverpod/dues_calendar/dues_calendar_notifier.dart';
import 'widgets/calendar_menu.dart';
import 'widgets/calendar_menu_detail.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({
    Key? key,
  }) : super(key: key);

  @override
  createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        ref.refresh(getDuesCalendar);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 32.0,
          ),
          child: Column(
            children: const [
              CalendarMenu(),
              SizedBox(height: 32.0),
              CalendarMenuDetail(),
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}
