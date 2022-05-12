import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../injection.dart';
import '../../../data/model/dues_category/dues_category_model.dart';
import '../../../utils/utils.dart';
import '../../riverpod/dues_category/dues_category_notifier.dart';

class DuesCategoryFormPage extends ConsumerStatefulWidget {
  const DuesCategoryFormPage({
    Key? key,
    required this.duesCategoryID,
  }) : super(key: key);

  final String duesCategoryID;

  @override
  createState() => _DuesCategoryFormPageState();
}

class _DuesCategoryFormPageState extends ConsumerState<DuesCategoryFormPage> {
  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  static const _locale = 'id';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency => NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  static final _outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: grey),
  );

  final _inputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: "",
    hintStyle: bFont.copyWith(fontSize: 12.0, color: grey),
    enabledBorder: _outlineInputBorder,
    focusedBorder: _outlineInputBorder.copyWith(borderSide: const BorderSide(color: primary)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
  );

  DuesCategoryModel? category;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _getCategory());
  }

  Future<void> _getCategory() async {
    final duesCategoryID = int.parse(widget.duesCategoryID);

    final result = (await ref.watch(getDuesCategoryByID(duesCategoryID).future)).item;

    setState(() {
      category = result;
      codeController.text = category?.code ?? "";
      nameController.text = category?.name ?? "";
      amountController.text = _formatNumber("${category?.amount ?? 0}");
      descriptionController.text = category?.description ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          category?.name ?? "Tambah Kategori",
          style: hFontWhite.copyWith(
            // fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16.0),
                ...[
                  Text(
                    'Kode',
                    style: hFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: codeController,
                    style: bFont.copyWith(fontWeight: FontWeight.bold),
                    decoration: _inputDecoration.copyWith(hintText: "Kode"),
                  ),
                ],
                const SizedBox(height: 16.0),
                ...[
                  Text(
                    'Nama',
                    style: hFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: nameController,
                    style: bFont.copyWith(fontWeight: FontWeight.bold),
                    decoration: _inputDecoration.copyWith(hintText: "Nama"),
                  ),
                ],
                const SizedBox(height: 16.0),
                ...[
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
                    decoration: _inputDecoration.copyWith(prefixText: _currency),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        /// Convert from 25000 => 25.000
                        value = _formatNumber(value);
                      }

                      amountController.value = TextEditingValue(
                        text: value,
                        selection: TextSelection.collapsed(offset: value.length),
                      );
                    },
                  ),
                  const SizedBox(height: 8.0),
                ],
                const SizedBox(height: 16.0),
                ...[
                  Text(
                    'Deskripsi',
                    style: hFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: descriptionController,
                    minLines: 3,
                    maxLines: 3,
                    style: bFont.copyWith(fontWeight: FontWeight.bold),
                    decoration: _inputDecoration.copyWith(hintText: "Nama"),
                  ),
                ],
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final result = await ref.read(duesCategoryNotifier.notifier).saveDuesCategory(
                            duesCategoryId: category?.id,
                            code: codeController.text,
                            name: nameController.text,
                            amount: int.parse(amountController.text.replaceAll(".", "")),
                            description: descriptionController.text,
                          );

                      if (result.isError) {
                        throw Exception(result.message);
                      }
                      sharedFunction.showSnackbar(
                        context,
                        color: Colors.green,
                        title: result.message ?? "",
                      );
                    } catch (e) {
                      sharedFunction.showSnackbar(
                        context,
                        color: Colors.red,
                        title: "$e",
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: primary,
                  ),
                  child: Text(
                    "Submit",
                    style: bFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
