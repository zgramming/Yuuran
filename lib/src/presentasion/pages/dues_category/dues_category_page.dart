import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import '../../riverpod/dues_category/dues_categories_notifier.dart';

class DuesCategoryPage extends ConsumerWidget {
  const DuesCategoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                "duesCategoryID": "0",
              },
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final future = ref.watch(getDuesCategories);
          return future.when(
            data: (items) => RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                ref.refresh(getDuesCategories);
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: items.length,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  final item = items[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: primaryShade,
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${item.code}",
                              style: bFontWhite.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        item.name ?? "",
                        style: hFont.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        item.description ?? "",
                        style: bFont.copyWith(
                          color: grey,
                          fontSize: 10.0,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () => context.pushNamed(
                          duesCategoryFormRouteName,
                          params: {
                            "duesCategoryID": "${item.id}",
                          },
                        ),
                        icon: const Icon(Icons.edit, color: info),
                      ),
                    ),
                  );
                },
              ),
            ),
            error: (error, trace) => Center(child: Text("Error $error")),
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
