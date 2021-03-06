import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './widgets/dues_recent_activity_list.dart';
import './widgets/dues_statistics_list.dart';
import './widgets/home_monthyear_picker.dart';
import '../../../utils/utils.dart';
import '../../riverpod/app_config/app_config_notifier.dart';
import '../../riverpod/dues/dues_recent_activity_notifier.dart';
import '../../riverpod/dues/dues_statistics_notifier.dart';
import '../../riverpod/parameter/selected_year_month_parameter.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        /// Delay 1 Second before refresh
        await Future.delayed(const Duration(seconds: 1));

        /// Refresh Statistics & Recent Activity
        ref.invalidate(getDuesStatistics);
        ref.invalidate(getDuesRecentActivity);

        sharedFunction.showSnackbar(context, color: Colors.green, title: "Refresh iuran");
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final userSession =
                                ref.watch(appConfigNotifer).itemAsync.value?.userSession;
                            return Text.rich(
                              TextSpan(
                                style: hFont.copyWith(fontSize: 14.0),
                                text: "Hello ",
                                children: [
                                  TextSpan(
                                    text: userSession?.name,
                                    style: hFont.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: OutlinedButton(
                            onPressed: () async => await showDialog(
                              context: context,
                              builder: (ctx) => const MonthYearPicker(),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: secondaryDark),
                            ),
                            child: Text(
                              "Ubah Bulan & Tahun",
                              style: bFont.copyWith(color: secondaryDark),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(blurRadius: 2.0, color: black.withOpacity(.25)),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(pathLogo, fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              Consumer(
                builder: (context, ref, child) {
                  final param = ref.watch(selectedYearMonthParameter);
                  return Text(
                    "Statistik Iuran ${sharedFunction.monthString(param.month)} ${param.year}",
                    style: hFont.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 20.0,
                      letterSpacing: 1.1,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              const DuesStatisticsList(),
              const SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final param = ref.watch(selectedYearMonthParameter);
                      return Text(
                        "Aktifitas Terbaru ${sharedFunction.monthString(param.month)} ${param.year}",
                        style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const DuesRecentActivityList(),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
