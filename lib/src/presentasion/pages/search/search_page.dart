import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import '../../riverpod/citizen/citizen_notifier.dart';
import 'widgets/search_modal_choose_option.dart';
import 'widgets/search_modal_filter.dart';

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
                    Consumer(
                      builder: (context, ref, child) {
                        final _citizen = ref.watch(getCitizenGrouping);
                        return _citizen.when(
                          data: (data) => Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (final entry in data.entries) ...[
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
                          ),
                          error: (error, trace) => Center(child: Text("Error $error")),
                          loading: () => const Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ],
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
