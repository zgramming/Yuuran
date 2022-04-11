import 'package:flutter/material.dart';

import '../../../../data/model/dues_category/dues_category_model.dart';
import '../../../../utils/utils.dart';
import '../../widgets/dues_detail_card.dart';

class DuesStatisticsModalDetail extends StatelessWidget {
  const DuesStatisticsModalDetail({
    Key? key,
    required this.item,
  }) : super(key: key);

  final DuesCategoryModel item;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...item.duesDetail
                .map(
                  (e) => DuesDetailCard(
                    item: e,
                    onTap: () => gotoPage.duesFormUpdate(
                      context,
                      duesDetailID: e.id!,
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
