import 'package:equatable/equatable.dart';

class SelectedMonthYearParameter extends Equatable {
  final int month;
  final int year;
  final int limit;

  const SelectedMonthYearParameter({
    this.month = 0,
    this.year = 0,
    this.limit = 20,
  });

  @override
  List<Object> get props => [month, year];

  @override
  String toString() => 'SelectedMonthYearParameter(month: $month, year: $year)';

  SelectedMonthYearParameter copyWith({
    int? month,
    int? year,
  }) {
    return SelectedMonthYearParameter(
      month: month ?? this.month,
      year: year ?? this.year,
    );
  }
}
