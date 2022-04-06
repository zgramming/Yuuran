import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../main.dart';
import '../../../utils/utils.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(color: grey),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16.0),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 12.0),
              decoration: InputDecoration(
                hintText: "Cari warga berdasarkan namanya",
                hintStyle: bFont.copyWith(fontSize: 10.0, color: grey),
                prefixIcon: const Icon(Icons.search),
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder.copyWith(
                  borderSide: const BorderSide(color: primary),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton(
                    onPressed: () => context.pushNamed(
                      citizenFormRouteName,
                      params: {
                        "username": "zeffry",
                      },
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: secondary,
                      side: const BorderSide(color: secondary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: Text(
                      "Tambah Warga",
                      style: bFont.copyWith(
                        color: secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  for (final entry in sharedFunction
                      .groupByFirstCharacter(Person.persons.map((e) => e.name).toList())
                      .entries) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Card(
                        color: primary,
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            entry.key,
                            style: hFontWhite.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ListView.separated(
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemCount: entry.value.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        final name = entry.value[index];
                        return ListTile(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
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
                                        context.pushNamed(
                                          citizenDuesRouteName,
                                          params: {
                                            "username": name,
                                          },
                                        );
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

                                        context.pushNamed(
                                          citizenFormRouteName,
                                          params: {"username": name},
                                        );
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
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundColor: primaryShade2,
                            child: FittedBox(
                              child: Text(
                                name[0],
                                style: hFontWhite.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          title: Text(
                            '$name',
                            style: hFont.copyWith(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
