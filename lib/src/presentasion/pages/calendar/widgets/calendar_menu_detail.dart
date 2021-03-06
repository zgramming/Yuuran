import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/utils.dart';
import '../../../riverpod/dues/dues_calendar_notifier.dart';
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
            return DuesDetailCard(
              onTap: () => gotoPage.duesFormUpdate(
                context,
                duesDetailID: item.id!,
              ),
              item: item,
            );
          },
        );
      },
    );
  }
}
