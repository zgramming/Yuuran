part of '../dues_form_page.dart';

class _InputDropdownDuesCategory extends StatelessWidget {
  const _InputDropdownDuesCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Pilih Kategori Iuran',
          style: hFont.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Consumer(
          builder: (context, ref, child) {
            final future = ref.watch(getDuesCategories);
            return future.when(
              data: (items) {
                final duesCategoryId =
                    ref.watch(duesFormParameter.select((value) => value.duesCategoryId));
                final selectedDuesCategory =
                    items.firstWhereOrNull((element) => element.id == duesCategoryId);
                return DropdownButton<DuesCategoryModel>(
                  isExpanded: true,
                  value: selectedDuesCategory,
                  hint: Text(
                    "Pilih kategori iuran",
                    style: bFont.copyWith(fontSize: 12.0, color: grey),
                  ),
                  items: items
                      .map((e) => DropdownMenuItem(value: e, child: Text(e.name ?? "")))
                      .toList(),
                  onChanged: (value) => ref
                      .watch(duesFormParameter.notifier)
                      .update((state) => state.copyWith(duesCategoryId: value?.id)),
                );
              },
              error: (error, trace) => Center(child: Text("Error $error")),
              loading: () => const Center(child: CircularProgressIndicator()),
            );
          },
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
