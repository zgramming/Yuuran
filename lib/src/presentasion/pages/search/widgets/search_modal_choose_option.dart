import 'package:flutter/material.dart';

import '../../../../data/model/user/user_model.dart';
import '../../../../utils/utils.dart';

class SearchModalChooseOption extends StatelessWidget {
  const SearchModalChooseOption({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Pilih aksi",
        style: hFont.copyWith(fontWeight: FontWeight.bold),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              gotoPage.citizenDues(context, username: user.username);
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
            ),
            child: Text(
              "Lihat Iuran",
              style: bFont.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              gotoPage.citizenFormUpdate(context, id: user.id!);
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
            ),
            child: Text(
              "Update Profile",
              style: bFont.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
          ),
          child: Text("Batal", style: bFont.copyWith(color: grey)),
        ),
      ],
    );
  }
}
