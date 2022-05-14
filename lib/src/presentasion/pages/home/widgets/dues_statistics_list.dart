import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../utils/utils.dart';
import '../../../riverpod/dues/dues_statistics_notifier.dart';
import 'dues_statistics_modal_detail.dart';

class DuesStatisticsList extends StatelessWidget {
  const DuesStatisticsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Consumer(
        builder: (context, ref, child) {
          final future = ref.watch(getDuesStatistics);
          return future.when(
            data: (items) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: items.duesCategory.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16.0),
                itemBuilder: (ctx, index) {
                  final item = items.duesCategory[index];
                  return SizedBox(
                    width: sharedFunction.vw(context) / 1.2,
                    child: InkWell(
                      onTap: () async {
                        if (item.duesDetail.isEmpty) return;

                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (ctx) => DuesStatisticsModalDetail(item: item),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [secondary, secondaryShade],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2.0,
                              color: black.withOpacity(.25),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '${item.name} (${item.code})'.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  hFontWhite.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          text: "${item.duesDetail.length}/${items.totalCitizen} ",
                                          children: [
                                            TextSpan(
                                              text: "Orang",
                                              style: bFontWhite.copyWith(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        style: bFontWhite.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Dana terkumpul",
                                            style: bFontWhite.copyWith(fontSize: 10.0),
                                          ),
                                          Consumer(
                                            builder: (context, ref, child) {
                                              final totalSummary =
                                                  ref.watch(duesStatisticsSummary(item.id ?? 0));
                                              return Text(
                                                "Rp.${NumberFormat().format(totalSummary)}",
                                                style: hFontWhite.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  Container(
                                    height: 10.0,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: FractionallySizedBox(
                                      widthFactor: (item.duesDetail.length / items.totalCitizen),
                                      child: Container(
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: secondaryDark,
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            error: (error, trace) => Center(child: Text("Error $error")),
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
