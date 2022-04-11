import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../utils/utils.dart';
import '../../../riverpod/dues_statistics/dues_statistics_notifier.dart';

class DuesStatisticsList extends StatelessWidget {
  const DuesStatisticsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sharedFunction.vh(context) / 4,
      child: Consumer(
        builder: (context, ref, child) {
          final _getDuesStatistics = ref.watch(getDuesStatistics);
          return _getDuesStatistics.when(
            data: (data) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: data.item?.duesCategory.length,
                itemExtent: sharedFunction.vw(context) / 1.25,
                itemBuilder: (ctx, index) {
                  final _duesCategory = data.item?.duesCategory[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                    margin: const EdgeInsets.only(right: 16.0),
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
                          '${_duesCategory?.name} (${_duesCategory?.code})'.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: hFontWhite.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                                      text:
                                          "${_duesCategory?.duesDetail.length}/${data.item?.totalCitizen} ",
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
                                      Text(
                                        "Rp." +
                                            GlobalFunction.formatNumber(
                                              data.sumDuesByCategories(_duesCategory?.id ?? 0),
                                            ),
                                        style: hFontWhite.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
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
                                  widthFactor: (4 / 10),
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
