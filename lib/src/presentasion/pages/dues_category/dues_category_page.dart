import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';

class DuesCategoryPage extends StatelessWidget {
  const DuesCategoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Kategori Iuran",
          style: hFontWhite.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(
              duesCategoryFormRouteName,
              params: {
                "codeCategory": "0",
              },
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (ctx, state) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: primaryShade,
                child: FittedBox(
                  child: Text(
                    "IKB",
                    style: bFontWhite.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Text(
                "Iuran Kebersihan",
                style: hFont.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Disini deskripsi iuran kebersihan loh",
                style: bFont.copyWith(
                  color: grey,
                  fontSize: 10.0,
                ),
              ),
              trailing: IconButton(
                onPressed: () => context.pushNamed(
                  duesCategoryFormRouteName,
                  params: {
                    "codeCategory": "test",
                  },
                ),
                icon: const Icon(Icons.edit, color: info),
              ),
            ),
          );
        },
      ),
    );
  }
}
