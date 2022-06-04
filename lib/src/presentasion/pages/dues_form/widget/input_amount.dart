part of '../dues_form_page.dart';

class _InputAmount extends ConsumerStatefulWidget {
  const _InputAmount({Key? key}) : super(key: key);

  @override
  __InputAmountState createState() => __InputAmountState();
}

class __InputAmountState extends ConsumerState<_InputAmount> {
  final amountController = TextEditingController();

  static const _locale = 'id';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency => NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  void initState() {
    super.initState();
    final amount = ref.read(duesFormParameter).amount;
    amountController.text = _formatNumber("$amount");
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Jumlah Iuran',
          style: hFont.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: amountController,
          style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 12.0),
          keyboardType: TextInputType.number,
          decoration: sharedFunction.myInputDecoration.copyWith(prefixText: _currency),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            if (value.isNotEmpty) {
              value = _formatNumber(value.replaceAll(",", ""));
            } else {
              value = "0";
            }

            amountController.value = TextEditingValue(
              text: value,
              selection: TextSelection.collapsed(offset: value.length),
            );

            /// Update state
            final amountInteger = int.tryParse(value.replaceAll(".", "")) ?? 0;
            ref
                .watch(duesFormParameter.notifier)
                .update((state) => state.copyWith(amount: amountInteger));
          },
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
