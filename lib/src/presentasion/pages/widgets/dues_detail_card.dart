import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

import '../../../data/model/dues_detail/dues_detail_model.dart';
import '../../../utils/utils.dart';

class DuesDetailCard extends StatelessWidget {
  const DuesDetailCard({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  final DuesDetailModel item;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: item.status == StatusPaid.notPaidOff ? warning : secondary,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
              ),
              child: Text(
                "${item.duesCategory?.name} (${item.duesCategory?.code})",
                style: hFontWhite.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "${item.user?.name}",
                style: hFont.copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Membayar Iuran untuk bulan ",
                        children: [
                          TextSpan(
                            text: sharedFunction.monthString(item.month ?? 0) +
                                " " +
                                item.year.toString(),
                            style: bFont.copyWith(
                              fontWeight: FontWeight.bold,
                              color: secondaryDark,
                            ),
                          ),
                        ],
                      ),
                      style: bFont.copyWith(
                        color: grey,
                        fontSize: 12.0,
                      ),
                    ),
                    if (item.description.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text.rich(
                        TextSpan(
                          text: "Deskripsi : ",
                          children: [
                            TextSpan(
                              text: item.description,
                            ),
                          ],
                        ),
                        // item.description,
                        style: bFont.copyWith(
                          color: grey,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              trailing: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    GlobalFunction.formatNumber(item.amount),
                    style: bFont.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
