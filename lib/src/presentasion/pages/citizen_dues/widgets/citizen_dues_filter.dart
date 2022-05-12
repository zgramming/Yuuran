import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/model/dues_category/dues_category_model.dart';
import '../../../../utils/utils.dart';
import '../../../riverpod/dues_category/dues_category_notifier.dart';
import '../../../riverpod/dues_citizen/dues_citizen_notifier.dart';

class CitizenDuesFilter extends ConsumerStatefulWidget {
  const CitizenDuesFilter({
    Key? key,
  }) : super(key: key);

  @override
  createState() => _CitizenDuesFilterState();
}

class _CitizenDuesFilterState extends ConsumerState<CitizenDuesFilter> {
  final years = <int>[for (int year = 2010; year <= 2020; year++) year];

  final months = <int>[for (int month = 1; month <= 12; month++) month];

  late int _selectedYear;
  late int _selectedMonth;
  DuesCategoryModel? _selectedDuesCategory;

  @override
  void initState() {
    super.initState();
    final parameter = ref.read(duesCitizenParameter);
    _selectedMonth = parameter.month;
    _selectedYear = parameter.year;
    _selectedDuesCategory = parameter.duesCategory;
  }

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
          Consumer(
            builder: (context, ref, child) {
              final categories = ref.watch(getDuesCategory);
              return categories.when(
                data: (data) => DropdownButton<DuesCategoryModel>(
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
                  items: [...data.items]
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.name ?? "",
                            style: bFont.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                error: (error, trace) => Center(child: Text("Error $error")),
                loading: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
          const SizedBox(height: 16.0),
          DropdownButton<int>(
            isExpanded: true,
            items: years
                .map<DropdownMenuItem<int>>(
                  (year) => DropdownMenuItem<int>(
                    value: year,
                    child: Text(
                      '$year',
                      style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
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
            onChanged: (value) => setState(() => _selectedMonth = value ?? DateTime.now().month),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              ref.read(duesCitizenParameter.notifier).update(
                    (state) => state = state.copyWith(
                      duesCategory: _selectedDuesCategory,
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
