import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/utils.dart';
import '../../riverpod/app_config/app_config_notifier.dart';
import '../../riverpod/global/global_notifier.dart';
import './widgets/dues_recent_activity_list.dart';
import './widgets/dues_statistics_list.dart';
import './widgets/home_monthyear_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                          final userSession = ref.watch(appConfigNotifer).item.userSession;
                          return Text.rich(
                            TextSpan(
                              text: "Hello ",
                              children: [
                                TextSpan(
                                  text: userSession?.name,
                                  style: hFont.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            style: hFont.copyWith(
                              fontSize: 14.0,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: OutlinedButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (ctx) => const MonthYearPicker(),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: secondaryDark)),
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
                      BoxShadow(
                        blurRadius: 2.0,
                        color: black.withOpacity(.25),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      pathLogo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            Consumer(
              builder: (context, ref, child) {
                final _duesParameter = ref.watch(duesParameter);
                return Text(
                  "Statistik Iuran ${sharedFunction.monthString(_duesParameter.month)} ${_duesParameter.year}",
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
                    final _duesParameter = ref.watch(duesParameter);
                    return Text(
                      "Aktifitas Terbaru ${sharedFunction.monthString(_duesParameter.month)} ${_duesParameter.year}",
                      style: bFont.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    );
                  },
                ),
                // TextButton(
                //   onPressed: () {},
                //   child: Text(
                //     'Lihat Semua',
                //     style: bFont.copyWith(
                //         fontWeight: FontWeight.bold, fontSize: 10.0, color: secondaryDark),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 16.0),
            const DuesRecentActivityList(),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
