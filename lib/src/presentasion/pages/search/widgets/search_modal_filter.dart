import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/utils.dart';
import '../../../riverpod/citizen/citizen_notifier.dart';
import 'search_modal_choose_option.dart';

class SearchModalFilter extends ConsumerStatefulWidget {
  const SearchModalFilter({
    Key? key,
  }) : super(key: key);

  @override
  createState() => _SearchModalFilterState();
}

class _SearchModalFilterState extends ConsumerState<SearchModalFilter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sharedFunction.vh(context) / 1.05,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(
            title: TextFormField(
              autofocus: true,
              cursorColor: Colors.white,
              style: bFontWhite.copyWith(fontWeight: FontWeight.bold),
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                ref.read(citizenQuery.notifier).update((state) => state = value);
              },
              decoration: InputDecoration(
                hintText: "Cari warga berdasarkan nama",
                hintStyle: bFontWhite.copyWith(fontSize: 12.0, color: Colors.white54),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final itemsFiltered = ref.watch(citizenGroupingFiltered);
                return ListView.builder(
                  itemCount: itemsFiltered.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (ctx, index) {
                    final user = itemsFiltered[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (ctx) => SearchModalChooseOption(user: user),
                          );
                        },
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: CircleAvatar(
                          backgroundColor: primaryShade2,
                          foregroundColor: Colors.white,
                          child: FittedBox(
                            child: Text(user.name[0]),
                          ),
                        ),
                        title: Text(
                          user.name,
                          style: hFont.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
