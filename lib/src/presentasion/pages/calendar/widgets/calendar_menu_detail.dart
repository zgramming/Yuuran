import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../riverpod/dues_calendar/dues_calendar_notifier.dart';
import '../../widgets/dues_detail_card.dart';

class CalendarMenuDetail extends StatelessWidget {
  const CalendarMenuDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final items = ref.watch(duesCalendarByDate);
        return ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            final item = items[index];
            return DuesDetailCard(item: item);
          },
        );
      },
    );
  }
}
