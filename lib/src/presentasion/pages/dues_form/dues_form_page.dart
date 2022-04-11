import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';
import 'package:intl/intl.dart';

import '../../../../injection.dart';
import '../../../data/model/dues_category/dues_category_model.dart';
import '../../../data/model/dues_detail/dues_detail_model.dart';
import '../../../data/model/user/user_model.dart';
import '../../../utils/utils.dart';
import '../../riverpod/app_config/app_config_notifier.dart';
import '../../riverpod/citizen/citizen_notifier.dart';
import '../../riverpod/dues_category/dues_category_notifier.dart';

class DuesFormPage extends ConsumerStatefulWidget {
  const DuesFormPage({
    Key? key,
    required this.duesDetailID,
  }) : super(key: key);

  final String duesDetailID;
  @override
  _DuesFormPageState createState() => _DuesFormPageState();
}

class _DuesFormPageState extends ConsumerState<DuesFormPage> {
  final years = <int>[
    for (final year in GlobalFunction.range(min: 2010, max: DateTime.now().year)) year
  ];

  final months = <int>[for (final month in GlobalFunction.range(min: 1, max: 12)) month];

  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  final now = DateTime.now();

  DuesDetailModel? duesDetail;

  int? _selectedYear;
  int? _selectedMonth;
  UserModel? _selectedCitizen;
  DuesCategoryModel? _selectedDuesCategory;
  bool _selectedPaidBySomeoneElse = false;
  StatusPaid _selectedStatus = StatusPaid.notPaidOff;

  static const _locale = 'id';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency => NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _getDuesDetail());
  }

  Future<void> _getDuesDetail() async {
    final result = await ref.read(duesDetailNotifier.notifier).getByID(widget.duesDetailID);
    setState(() {
      duesDetail = result.item;
      _selectedYear = duesDetail?.year ?? now.year;
      _selectedMonth = duesDetail?.month ?? now.month;
      _selectedCitizen = duesDetail?.user;
      _selectedDuesCategory = duesDetail?.duesCategory;
      _selectedPaidBySomeoneElse = (duesDetail?.paidBySomeoneElse ?? true) == 1;
      _selectedStatus = duesDetail?.status ?? StatusPaid.notPaidOff;

      amountController.text = _formatNumber("${duesDetail?.amount ?? 0}");
      descriptionController.text = duesDetail?.description ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          duesDetail == null ? "Tambah Iuran" : "Update Iuran",
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
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: DropdownButton<int>(
                                isExpanded: true,
                                value: _selectedMonth,
                                items: months
                                    .map<DropdownMenuItem<int>>(
                                      (month) => DropdownMenuItem<int>(
                                        child: Text(
                                          sharedFunction.monthString(month),
                                          style: bFont.copyWith(
                                              fontWeight: FontWeight.bold, fontSize: 16.0),
                                        ),
                                        value: month,
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) => setState(() => _selectedMonth = value),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Flexible(
                              child: DropdownButton<int>(
                                isExpanded: true,
                                value: _selectedYear,
                                items: years
                                    .map<DropdownMenuItem<int>>(
                                      (year) => DropdownMenuItem<int>(
                                        child: Text(
                                          '$year',
                                          style: bFont.copyWith(
                                              fontWeight: FontWeight.bold, fontSize: 16.0),
                                        ),
                                        value: year,
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) => setState(() => _selectedYear = value),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                      ],
                      ...[
                        Text(
                          'Pilih Warga',
                          style: hFont.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Consumer(
                          builder: (context, ref, child) {
                            final _getCitizen = ref.watch(getCitizen);
                            return _getCitizen.when(
                              data: (data) {
                                return DropdownButton<UserModel>(
                                  isExpanded: true,
                                  value: _selectedCitizen,
                                  hint: Text(
                                    "Pilih warga yang ingin dibuatkan iuran",
                                    style: bFont.copyWith(fontSize: 12.0, color: grey),
                                  ),
                                  items: data.items
                                      .map(
                                        (e) => DropdownMenuItem(child: Text(e.name), value: e),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() => _selectedCitizen = value);
                                  },
                                );
                              },
                              error: (error, trace) => Center(child: Text("Error $error")),
                              loading: () => const Center(child: CircularProgressIndicator()),
                            );
                          },
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
                        Consumer(
                          builder: (context, ref, child) {
                            final _getCategories = ref.watch(getDuesCategory);
                            return _getCategories.when(
                              data: (data) => DropdownButton<DuesCategoryModel>(
                                isExpanded: true,
                                value: _selectedDuesCategory,
                                hint: Text(
                                  "Pilih kategori iuran",
                                  style: bFont.copyWith(fontSize: 12.0, color: grey),
                                ),
                                items: data.items
                                    .map((e) =>
                                        DropdownMenuItem(child: Text(e.name ?? ""), value: e))
                                    .toList(),
                                onChanged: (value) => setState(() => _selectedDuesCategory = value),
                              ),
                              error: (error, trace) => Center(child: Text("Error $error")),
                              loading: () => const Center(child: CircularProgressIndicator()),
                            );
                          },
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
                          decoration:
                              sharedFunction.myInputDecoration.copyWith(prefixText: _currency),
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
                          decoration:
                              sharedFunction.myInputDecoration.copyWith(hintText: "Keterangan"),
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
                      ...[
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
                          groupValue: _selectedStatus,
                          onChanged: (value) => setState(
                            () => _selectedStatus = value ?? StatusPaid.notPaidOff,
                          ),
                          title: Text(
                            "Lunas",
                            style: hFont.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        RadioListTile<StatusPaid>(
                          value: StatusPaid.notPaidOff,
                          groupValue: _selectedStatus,
                          onChanged: (value) => setState(
                            () => _selectedStatus = value ?? StatusPaid.notPaidOff,
                          ),
                          title: Text(
                            "Belum lunas",
                            style: hFont.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          final userLogin = ref.read(appConfigNotifer).item.userSession;
                          final result = await ref.read(duesDetailNotifier.notifier).saveDues(
                                duesDetail == null ? "new" : duesDetail!.id!,
                                duesCategoryId: _selectedDuesCategory?.id ?? 0,
                                usersId: _selectedCitizen?.id ?? 0,
                                month: _selectedMonth ?? 0,
                                year: _selectedYear ?? 0,
                                amount: int.parse(amountController.text.replaceAll(".", "")),
                                status: _selectedStatus,
                                paidBySomeoneElse: _selectedPaidBySomeoneElse,
                                createdBy: userLogin?.id ?? 0,
                              );

                          if (result.isError) {
                            GlobalFunction.showSnackBar(
                              context,
                              content: Text(
                                result.message ?? '',
                                style: bFontWhite.copyWith(fontWeight: FontWeight.bold),
                              ),
                              snackBarType: SnackBarType.error,
                            );
                            return;
                          }

                          GlobalFunction.showSnackBar(
                            context,
                            content: Text(
                              result.message ?? '',
                              style: bFontWhite.copyWith(fontWeight: FontWeight.bold),
                            ),
                            snackBarType: SnackBarType.success,
                          );
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
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
