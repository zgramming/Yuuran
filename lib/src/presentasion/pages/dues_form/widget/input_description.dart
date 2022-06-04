part of '../dues_form_page.dart';

class _InputDescription extends ConsumerStatefulWidget {
  const _InputDescription({Key? key}) : super(key: key);

  @override
  __InputDescriptionState createState() => __InputDescriptionState();
}

class __InputDescriptionState extends ConsumerState<_InputDescription> {
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final description = ref.read(duesFormParameter).description;
    descriptionController.text = "$description";
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Keterangan',
          style: hFont.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: descriptionController,
          style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 12.0),
          minLines: 3,
          maxLines: 3,
          decoration: sharedFunction.myInputDecoration.copyWith(hintText: "Keterangan"),
          onChanged: (val) => ref
              .watch(duesFormParameter.notifier)
              .update((state) => state.copyWith(description: val)),
        ),
        const SizedBox(height: 8.0),
        Text(
          "Kamu bisa menggunakan field ini untuk memberikan keterangan pada iuran ini, bisa berupa alasan pembayaran iuran tidak full, alasan kenapa iuran dibayar oleh pihak lain, dan sebagainya.",
          style: bFont.copyWith(fontSize: 10.0, color: grey),
        ),
      ],
    );
  }
}
