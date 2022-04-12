import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/utils.dart';
import '../../../riverpod/dues_recent_activity/dues_recent_activity_notifier.dart';
import '../../widgets/dues_detail_card.dart';

class DuesRecentActivityList extends StatelessWidget {
  const DuesRecentActivityList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final _getRecentActivity = ref.watch(getDuesRecentActivity);
        return _getRecentActivity.when(
          data: (data) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.items.length,
              itemBuilder: (ctx, index) {
                final item = data.items[index];
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
          error: (error, trace) {
            final message = (error as DuesRecentActivityState).message;
            return Center(child: Text("Error $message"));
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
