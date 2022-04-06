import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

import '../../../utils/utils.dart';
import 'widgets/home_monthyear_picker.dart';

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
                      Text.rich(
                        TextSpan(
                          text: "Hello ",
                          children: [
                            TextSpan(
                              text: "Zeffry Reynando",
                              style: hFont.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        style: hFont.copyWith(
                          fontSize: 14.0,
                        ),
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
            Text(
              "Statistik Iuran April 2022",
              style: hFont.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 20.0,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: sharedFunction.vh(context) / 4,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 3,
                itemExtent: sharedFunction.vw(context) / 1.25,
                itemBuilder: (ctx, index) {
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
                          'Iuran Kebersihan (IRK)'.toUpperCase(),
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
                                      text: "4/10 ",
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
                                      Text("Dana terkumpul",
                                          style: bFontWhite.copyWith(fontSize: 10.0)),
                                      Text(
                                        GlobalFunction.formatNumber(250000),
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
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Aktifitas Terbaru April 2022",
                  style: bFont.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Lihat Semua',
                    style: bFont.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 10.0, color: secondaryDark),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (ctx, index) {
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
                          index.isOdd ? "IURAN KEAMANAN (IRKM)" : "IURAN KEBERSIHAN (IRKB)",
                          style: hFontWhite,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Zeffry Reynando",
                          style: hFont.copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Update terakhir ${GlobalFunction.formatYMDHM(DateTime.now())}",
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
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
