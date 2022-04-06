import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import 'widgets/citizen_dues_filter.dart';

class CitizenDuesPage extends StatelessWidget {
  const CitizenDuesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Iuran XXX"),
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (ctx) => const CitizenDuesFilter(),
              );
            },
            icon: const Icon(Icons.filter_alt),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: secondary,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2.0,
                  color: black.withOpacity(.25),
                ),
              ],
            ),
            child: Text(
              "Iuran Kebersihan April 2022",
              style: hFontWhite.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                letterSpacing: 1.1,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () => context.pushNamed(duesRouteName),
                  child: Card(
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
