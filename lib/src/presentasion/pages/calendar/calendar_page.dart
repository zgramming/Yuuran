import 'package:flutter/material.dart';

import 'widgets/calendar_menu.dart';
import 'widgets/calendar_menu_detail.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
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
          children: const [
            CalendarMenu(),
            SizedBox(height: 32.0),
            CalendarMenuDetail(),
            SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
