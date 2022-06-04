part of '../dues_form_page.dart';

class _InputDropdowpMonth extends ConsumerWidget {
  const _InputDropdowpMonth({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final months = <int>[for (int month = 1; month <= 12; month++) month];
    final selectedMonth = ref.watch(duesFormParameter.select((value) => value.month));
    return Flexible(
      child: DropdownButton<int>(
        isExpanded: true,
        value: selectedMonth,
        hint: const Text("Pilih Bulan"),
        items: months
            .map<DropdownMenuItem<int>>(
              (month) => DropdownMenuItem<int>(
                value: month,
                child: Text(
                  sharedFunction.monthString(month),
                  style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            )
            .toList(),
        onChanged: (value) =>
            ref.watch(duesFormParameter.notifier).update((state) => state.copyWith(month: value)),
      ),
    );
  }
}
