import 'package:equatable/equatable.dart';

import 'dues_category/dues_category_model.dart';

class DuesCitizenParameter extends Equatable {
  const DuesCitizenParameter({
    this.month = 0,
    this.year = 0,
    this.duesCategory,
  });

  final int month;
  final int year;
  final DuesCategoryModel? duesCategory;

  @override
  List<Object?> get props => [month, year, duesCategory];

  @override
  String toString() =>
      'DuesCitizenParameter(month: $month, year: $year, duesCategory: $duesCategory)';

  DuesCitizenParameter copyWith({
    int? month,
    int? year,
    DuesCategoryModel? duesCategory,
  }) {
    return DuesCitizenParameter(
      month: month ?? this.month,
      year: year ?? this.year,
      duesCategory: duesCategory ?? this.duesCategory,
    );
  }
}
