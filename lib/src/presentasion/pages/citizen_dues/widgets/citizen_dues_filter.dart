import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/model/dues_category/dues_category_model.dart';
import '../../../../data/model/dues_citizen_parameter.dart';
import '../../../../utils/utils.dart';
import '../../../riverpod/dues_category/dues_categories_notifier.dart';
import '../../../riverpod/parameter/dues_citizen_parameter.dart';

class CitizenDuesFilter extends ConsumerStatefulWidget {
  const CitizenDuesFilter({
    Key? key,
  }) : super(key: key);

  @override
  createState() => _CitizenDuesFilterState();
}

class _CitizenDuesFilterState extends ConsumerState<CitizenDuesFilter> {
  final years = <int>[for (int year = 2010; year <= DateTime.now().year; year++) year];

  final months = <int>[for (int month = 1; month <= 12; month++) month];

  int? _selectedYear;
  int? _selectedMonth;
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
      title: Text("Filter berdasarkan :", style: hFont.copyWith(fontWeight: FontWeight.bold)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16.0),
          Consumer(
            builder: (context, ref, child) {
              final categories = ref.watch(getDuesCategories);
              return categories.when(
                data: (items) => DropdownButton<DuesCategoryModel>(
                  value: _selectedDuesCategory,
                  isExpanded: true,
                  hint: Text(
                    "Pilih Kategori",
                    style: bFont.copyWith(color: grey, fontWeight: FontWeight.bold),
                  ),
                  onChanged: (value) => setState(() => _selectedDuesCategory = value),
                  items: [...items]
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
            value: _selectedYear,
            onChanged: (value) => setState(() => _selectedYear = value ?? DateTime.now().year),
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
          ),
          const SizedBox(height: 16.0),
          DropdownButton<int>(
            isExpanded: true,
            value: _selectedMonth,
            onChanged: (value) => setState(() => _selectedMonth = value ?? DateTime.now().month),
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
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              final param = DuesCitizenParameter(
                duesCategory: _selectedDuesCategory,
                month: _selectedMonth ?? 0,
                year: _selectedYear ?? 0,
              );
              ref.watch(duesCitizenParameter.notifier).update((state) => state = param);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0), primary: primary),
            child: Text(
              "Submit",
              style: bFont.copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
