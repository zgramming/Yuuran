import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../utils/utils.dart';

class DuesCategoryFormPage extends StatefulWidget {
  const DuesCategoryFormPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DuesCategoryFormPage> createState() => _DuesCategoryFormPageState();
}

class _DuesCategoryFormPageState extends State<DuesCategoryFormPage> {
  final amountController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Iuran Kebersihan",
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
                      log("before value $value");
                      if (value.isNotEmpty) value = _formatNumber(value.replaceAll(",", ""));

                      log("after value value $value");
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
                    minLines: 3,
                    maxLines: 3,
                    style: bFont.copyWith(fontWeight: FontWeight.bold),
                    decoration: _inputDecoration.copyWith(hintText: "Nama"),
                  ),
                ],
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {},
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
