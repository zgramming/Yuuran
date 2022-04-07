import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../data/model/dues_detail/dues_detail_model.dart';
import '../../../../utils/utils.dart';
import '../../../riverpod/dues_recent_activity/dues_recent_activity_notifier.dart';

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
                final duesDetail = data.items[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: duesDetail.status == StatusPaid.notPaidOff ? warning : secondary,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                        ),
                        child: Text(
                          "${duesDetail.duesCategory?.name} (${duesDetail.duesCategory?.code})",
                          style: hFontWhite,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          duesDetail.user?.name ?? '',
                          style: hFont.copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            GlobalFunction.formatYMDHM(duesDetail.createdAt!),
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
                              GlobalFunction.formatNumber(duesDetail.amount),
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
          error: (error, trace) => Center(child: Text("Error $error")),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
