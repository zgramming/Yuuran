part of '../dues_form_page.dart';

class _InputStatus extends ConsumerWidget {
  const _InputStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatusPaid = ref.watch(duesFormParameter.select((value) => value.statusPaid));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Status',
          style: hFont.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        RadioListTile<StatusPaid>(
          value: StatusPaid.paidOff,
          groupValue: selectedStatusPaid,
          onChanged: (value) => ref
              .watch(duesFormParameter.notifier)
              .update((state) => state.copyWith(statusPaid: value)),
          title: Text(
            "Lunas",
            style: hFont.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        RadioListTile<StatusPaid>(
            value: StatusPaid.notPaidOff,
            groupValue: selectedStatusPaid,
            title: Text(
              "Belum lunas",
              style: hFont.copyWith(fontWeight: FontWeight.bold),
            ),
            onChanged: (value) => ref
                .watch(duesFormParameter.notifier)
                .update((state) => state.copyWith(statusPaid: value))),
      ],
    );
  }
}
