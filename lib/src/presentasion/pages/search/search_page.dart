import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/utils.dart';
import '../../riverpod/citizen/citizens_notifier.dart';
import 'widgets/search_modal_choose_option.dart';
import 'widgets/search_modal_filter.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(color: grey),
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16.0),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                readOnly: true,
                onTap: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) => const SearchModalFilter(),
                  );
                },
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
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                ref.invalidate(citizenGrouping);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OutlinedButton(
                        onPressed: () => gotoPage.citizenFormNew(context),
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
                      //TODO: Masih ada bug, saat sudah tambah warga belum tampil tetapi sudah tersimpan di datbaase
                      Consumer(
                        builder: (context, ref, child) {
                          final grouping = ref.watch(citizenGrouping).value ?? {};
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (final entry in grouping.entries) ...[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Card(
                                    color: primary,
                                    margin: EdgeInsets.zero,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        entry.key,
                                        style: hFontWhite.copyWith(
                                            fontWeight: FontWeight.bold, fontSize: 20.0),
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
                                    final user = entry.value[index];
                                    return ListTile(
                                      onTap: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (ctx) => SearchModalChooseOption(user: user),
                                        );
                                      },
                                      leading: CircleAvatar(
                                        backgroundColor: primaryShade2,
                                        child: FittedBox(
                                          child: Text(
                                            user.name[0],
                                            style: hFontWhite.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        user.name,
                                        style: hFont.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 16.0),
                              ],
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
