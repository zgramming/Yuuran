import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../utils/utils.dart';
import '../../../riverpod/dues_calendar/dues_calendar_notifier.dart';

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
    );
  }
}
