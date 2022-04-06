import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import 'widgets/choose_action_menu.dart';

class ChooseActionPage extends StatelessWidget {
  const ChooseActionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16.0),
          ChooseActionMenu(
            onTap: () => context.pushNamed(duesRouteName),
            circleBackgroudColor: secondary,
            iconData: Icons.attach_money_rounded,
            title: "Tambah Iuran",
            subtitle: "Membuat dan menyimpan iuran warga",
          ),
          const SizedBox(height: 16.0),
          ChooseActionMenu(
            onTap: () => context.pushNamed(duesCategoryRouteName),
            circleBackgroudColor: warning,
            iconData: Icons.category_rounded,
            title: "Kategori Iuran",
            subtitle: "Memanage Kategori Iuran ",
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
