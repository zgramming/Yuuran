part of '../dues_form_page.dart';

class _DropdownYear extends ConsumerWidget {
  const _DropdownYear({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final years = <int>[for (int year = 2010; year <= DateTime.now().year; year++) year];
    final selectedYear = ref.watch(duesFormParameter.select((value) => value.year));
    return Flexible(
      child: DropdownButton<int>(
        isExpanded: true,
        value: selectedYear,
        hint: const Text("Pilih Tahun"),
        items: years
            .map<DropdownMenuItem<int>>(
              (year) => DropdownMenuItem<int>(
                value: year,
                child: Text(
                  '$year',
                  style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            )
            .toList(),
        onChanged: (value) =>
            ref.watch(duesFormParameter.notifier).update((state) => state.copyWith(year: value)),
      ),
    );
  }
}
