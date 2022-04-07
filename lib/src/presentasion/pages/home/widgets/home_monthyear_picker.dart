import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../../../utils/utils.dart';
import '../../../riverpod/dues_statistics/dues_statistics_notifier.dart';

class MonthYearPicker extends ConsumerStatefulWidget {
  const MonthYearPicker({
    Key? key,
  }) : super(key: key);

  @override
  _MonthYearPickerState createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends ConsumerState<MonthYearPicker> {
  final years = <int>[
    for (final year in GlobalFunction.range(min: 2010, max: DateTime.now().year)) year
  ];

  final months = <int>[for (final month in GlobalFunction.range(min: 1, max: 12)) month];

  late int _selectedYear;
  late int _selectedMonth;

  @override
  void initState() {
    super.initState();
    final _duesParameter = ref.read(duesParameter);
    _selectedYear = _duesParameter.year;
    _selectedMonth = _duesParameter.month;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text(
        "Pilih Bulan dan Tahun",
        style: hFont.copyWith(fontWeight: FontWeight.bold),
      ),
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
                    child: Text(
                      '$year',
                      style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    value: year,
                  ),
                )
                .toList(),
            value: _selectedYear,
            onChanged: (value) {
              setState(() => _selectedYear = value ?? DateTime.now().year);
            },
          ),
          const SizedBox(height: 16.0),
          DropdownButton<int>(
            isExpanded: true,
            items: months
                .map<DropdownMenuItem<int>>(
                  (month) => DropdownMenuItem<int>(
                    child: Text(
                      sharedFunction.monthString(month),
                      style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    value: month,
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
              ref.read(duesParameter.notifier).update(
                    (state) => state.copyWith(
                      month: _selectedMonth,
                      year: _selectedYear,
                    ),
                  );

              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
              primary: primary,
            ),
            child: Text(
              "Update",
              style: bFont.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
