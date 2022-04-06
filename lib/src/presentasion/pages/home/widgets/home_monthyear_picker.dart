import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

import '../../../../utils/utils.dart';

class MonthYearPicker extends StatefulWidget {
  const MonthYearPicker({
    Key? key,
  }) : super(key: key);

  @override
  State<MonthYearPicker> createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends State<MonthYearPicker> {
  final years = <int>[
    for (final year in GlobalFunction.range(min: 2010, max: DateTime.now().year)) year
  ];

  final months = <int>[for (final month in GlobalFunction.range(min: 1, max: 12)) month];

  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

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
            onPressed: () => Navigator.pop(context),
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
