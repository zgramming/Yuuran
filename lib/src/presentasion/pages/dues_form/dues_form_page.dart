import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/model/dues_category/dues_category_model.dart';
import '../../../data/model/dues_detail/dues_detail_model.dart';
import '../../../data/model/dues_response/dues_response_model.dart';
import '../../../data/model/user/user_model.dart';
import '../../../utils/utils.dart';
import '../../riverpod/app_config/app_config_notifier.dart';
import '../../riverpod/citizen/citizens_notifier.dart';
import '../../riverpod/dues/dues_action_notifier.dart';
import '../../riverpod/dues/dues_notifier.dart';
import '../../riverpod/dues_category/dues_categories_notifier.dart';
import '../widgets/modal_loading.dart';
import '../widgets/modal_success.dart';

class DuesFormPage extends ConsumerStatefulWidget {
  const DuesFormPage({
    Key? key,
    required this.duesDetailID,
  }) : super(key: key);

  final String duesDetailID;
  @override
  createState() => _DuesFormPageState();
}

class _DuesFormPageState extends ConsumerState<DuesFormPage> {
  final now = DateTime.now();
  final years = <int>[for (int year = 2010; year <= DateTime.now().year; year++) year];
  final months = <int>[for (int month = 1; month <= 12; month++) month];

  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  int? _selectedYear;
  int? _selectedMonth;
  UserModel? _selectedCitizen;
  DuesCategoryModel? _selectedDuesCategory;
  StatusPaid _selectedStatus = StatusPaid.notPaidOff;

  static const _locale = 'id';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency => NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  Widget build(BuildContext context) {
    /// Listen [duesNotifier] when load dues detail from API
    ref.listen<AsyncValue<DuesDetailModel?>>(
      getDuesDetail(widget.duesDetailID),
      (_, state) {
        state.whenData((value) {
          _selectedYear = value?.year;
          _selectedMonth = value?.month;
          _selectedCitizen = value?.user;
          _selectedDuesCategory = value?.duesCategory;
          _selectedStatus = value?.status ?? StatusPaid.notPaidOff;
          amountController.text = _formatNumber("${value?.amount ?? 0}");
          descriptionController.text = "${value?.description}";
        });
      },
    );

    /// Listen [duesActionNotifier] when saving data
    ref.listen<AsyncValue<DuesResponse?>>(
      duesActionNotifier.select((value) => value.saveAsync),
      (_, state) {
        if (state is AsyncLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const ModalLoadingWidget(),
          );
        } else {
          /// Close Modal Loading
          Navigator.pop(context);

          state.whenOrNull(
            data: (response) {
              showDialog(
                context: context,
                builder: (context) => ModalSuccessWidget(message: "${response?.message}"),
              );
            },
            error: (error, trace) {
              sharedFunction.showSnackbar(
                context,
                color: Colors.red,
                title: "$error",
              );
            },
          );
        }
      },
    );
    final future = ref.watch(getDuesDetail(widget.duesDetailID));
    if (future is AsyncLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (future is AsyncError) {
      final message = future.error;
      return Scaffold(body: Center(child: Text("$message")));
    }
    final duesDetail = future.value;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            duesDetail?.id == null ? "Tambah Iuran" : "Update Iuran",
            style: hFontWhite.copyWith(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(getDuesDetail(widget.duesDetailID));
          },
          child: SingleChildScrollView(
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
                                            value: month,
                                            child: Text(
                                              sharedFunction.monthString(month),
                                              style: bFont.copyWith(
                                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                                            ),
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
                                            value: year,
                                            child: Text(
                                              '$year',
                                              style: bFont.copyWith(
                                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                                            ),
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
                                final future = ref.watch(getCitizens);
                                return future.when(
                                  data: (data) {
                                    return DropdownButton<UserModel>(
                                      isExpanded: true,
                                      value: _selectedCitizen,
                                      hint: Text(
                                        "Pilih warga yang ingin dibuatkan iuran",
                                        style: bFont.copyWith(fontSize: 12.0, color: grey),
                                      ),
                                      items: data
                                          .map(
                                            (e) => DropdownMenuItem(value: e, child: Text(e.name)),
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
                                final future = ref.watch(getDuesCategories);
                                return future.when(
                                  data: (items) => DropdownButton<DuesCategoryModel>(
                                    isExpanded: true,
                                    value: _selectedDuesCategory,
                                    hint: Text(
                                      "Pilih kategori iuran",
                                      style: bFont.copyWith(fontSize: 12.0, color: grey),
                                    ),
                                    items: items
                                        .map((e) =>
                                            DropdownMenuItem(value: e, child: Text(e.name ?? "")))
                                        .toList(),
                                    onChanged: (value) =>
                                        setState(() => _selectedDuesCategory = value),
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
                              final userLogin =
                                  ref.read(appConfigNotifer).itemAsync.value?.userSession;
                              await ref.read(duesActionNotifier.notifier).saveDues(
                                    duesDetail == null ? "new" : duesDetail.id!,
                                    duesCategoryId: _selectedDuesCategory?.id ?? 0,
                                    usersId: _selectedCitizen?.id ?? 0,
                                    month: _selectedMonth ?? 0,
                                    year: _selectedYear ?? 0,
                                    amount: int.parse(amountController.text.replaceAll(".", "")),
                                    status: _selectedStatus,
                                    description: descriptionController.text,
                                    createdBy: userLogin?.id ?? 0,
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
        ),
      ),
    );
  }
}
