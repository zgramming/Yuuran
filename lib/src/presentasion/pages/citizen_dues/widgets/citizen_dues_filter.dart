import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';

import '../../../../utils/utils.dart';

class CitizenDuesFilter extends StatefulWidget {
  const CitizenDuesFilter({
    Key? key,
  }) : super(key: key);

  @override
  State<CitizenDuesFilter> createState() => _CitizenDuesFilterState();
}

class _CitizenDuesFilterState extends State<CitizenDuesFilter> {
  final years = <int>[
    for (final year in GlobalFunction.range(min: 2010, max: DateTime.now().year)) year
  ];

  final months = <int>[for (final month in GlobalFunction.range(min: 1, max: 12)) month];

  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;
  String? _selectedDuesCategory;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text(
        "Filter berdasarkan :",
        style: hFont.copyWith(fontWeight: FontWeight.bold),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16.0),
          DropdownButton<String>(
            value: _selectedDuesCategory,
            isExpanded: true,
            hint: Text(
              "Pilih Kategori",
              style: bFont.copyWith(
                color: grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            onChanged: (value) => setState(() => _selectedDuesCategory = value),
            items: ["Iuran Keamanan", "Iuran Kesehatan", "Iuran Kebersihan"]
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: bFont.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
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
            onChanged: (value) => setState(() => _selectedYear = value ?? DateTime.now().year),
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
            onChanged: (value) => setState(() => _selectedMonth = value ?? DateTime.now().month),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
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
    );
  }
}
