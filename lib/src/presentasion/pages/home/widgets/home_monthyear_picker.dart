import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/utils.dart';
import '../../../riverpod/parameter/selected_year_month_parameter.dart';

class MonthYearPicker extends ConsumerStatefulWidget {
  const MonthYearPicker({
    Key? key,
  }) : super(key: key);

  @override
  createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends ConsumerState<MonthYearPicker> {
  final years = <int>[for (int year = 2010; year <= DateTime.now().year; year++) year];
  final months = <int>[for (int month = 1; month <= 12; month++) month];

  int? _selectedYear;
  int? _selectedMonth;

  @override
  void initState() {
    super.initState();
    final param = ref.read(selectedYearMonthParameter);
    _selectedYear = param.year;
    _selectedMonth = param.month;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Text("Pilih Bulan dan Tahun", style: hFont.copyWith(fontWeight: FontWeight.bold)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16.0),
          DropdownButton<int>(
            isExpanded: true,
            items: years
                .map<DropdownMenuItem<int>>(
                  (year) => DropdownMenuItem<int>(
                    value: year,
                    child: Text(
                      '$year',
                      style: bFont.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                )
                .toList(),
            value: _selectedYear,
            onChanged: (value) => setState(() => _selectedYear = value ?? DateTime.now().year),
          ),
          const SizedBox(height: 16.0),
          DropdownButton<int>(
            isExpanded: true,
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
            value: _selectedMonth,
            onChanged: (value) {
              setState(() => _selectedMonth = value ?? DateTime.now().month);
            },
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              /// Initialize dues parameter
              ref
                  .watch(selectedYearMonthParameter.notifier)
                  .update((state) => state.copyWith(month: _selectedMonth, year: _selectedYear));

              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0), primary: primary),
            child: Text(
              "Update",
              style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
