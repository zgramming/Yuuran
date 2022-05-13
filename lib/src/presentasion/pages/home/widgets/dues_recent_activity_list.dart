import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/utils.dart';
import '../../../riverpod/dues/dues_recent_activity_notifier.dart';
import '../../widgets/dues_detail_card.dart';

class DuesRecentActivityList extends StatelessWidget {
  const DuesRecentActivityList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final future = ref.watch(getDuesRecentActivity);
        return future.when(
          data: (items) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
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
          error: (error, trace) => Center(child: Text("Error $error")),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
