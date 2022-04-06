import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../utils/utils.dart';

class DuesFormPage extends StatefulWidget {
  const DuesFormPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DuesFormPage> createState() => _DuesFormPageState();
}

class _DuesFormPageState extends State<DuesFormPage> {
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  String? _selectedCitizen;
  String? _selectedDuesCategory;
  bool _selectedPaidBySomeoneElse = false;

  static const _locale = 'id';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency => NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: grey),
    );
    final _inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: "0",
      hintStyle: bFont.copyWith(fontSize: 12.0, color: grey),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder.copyWith(borderSide: const BorderSide(color: primary)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Iuran",
          style: hFontWhite.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ...[
                        Text(
                          'Pilih Warga',
                          style: hFont.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        DropdownButton<String>(
                          isExpanded: true,
                          hint: Text(
                            "Pilih warga yang ingin dibuatkan iuran",
                            style: bFont.copyWith(fontSize: 12.0, color: grey),
                          ),
                          value: _selectedCitizen,
                          items: ["Zeffry Reynando", "Syarif", "Helmi", "Engkoh"]
                              .map((e) => DropdownMenuItem(child: Text(e), value: e))
                              .toList(),
                          onChanged: (value) => setState(() => _selectedCitizen = value),
                        ),
                        const SizedBox(height: 8.0),
                      ],
                      const SizedBox(height: 16.0),
                      ...[
                        Text(
                          'Pilih Kategori Iuran',
                          style: hFont.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        DropdownButton<String>(
                          isExpanded: true,
                          hint: Text(
                            "Pilih kategori iuran",
                            style: bFont.copyWith(fontSize: 12.0, color: grey),
                          ),
                          value: _selectedDuesCategory,
                          items: ["Iuran Kebersihan", "Iuran Kemanan", "Iuran Kesehatan"]
                              .map((e) => DropdownMenuItem(child: Text(e), value: e))
                              .toList(),
                          onChanged: (value) => setState(() => _selectedDuesCategory = value),
                        ),
                        const SizedBox(height: 8.0),
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
                        CheckboxListTile(
                          value: _selectedPaidBySomeoneElse,
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: const EdgeInsets.only(),
                          activeColor: primary,
                          title: Text(
                            "Dibayarkan orang lain ?",
                            style: hFont.copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Memberitahukan bahwa iuran ini dibayarkan oleh orang lain, bukan dengan warga yang bersangkutan.",
                            style: bFont.copyWith(
                              fontSize: 10.0,
                              color: grey,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() => _selectedPaidBySomeoneElse = value ?? false);
                          },
                        ),
                      ],
                      const SizedBox(height: 16.0),
                      ...[
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
                          decoration: _inputDecoration.copyWith(hintText: "Keterangan"),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          "Kamu bisa menggunakan field ini untuk memberikan keterangan pada iuran ini, bisa berupa alasan pembayaran iuran tidak full, alasan kenapa iuran dibayar oleh pihak lain, dan sebagainya.",
                          style: bFont.copyWith(
                            fontSize: 10.0,
                            color: grey,
                          ),
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
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
