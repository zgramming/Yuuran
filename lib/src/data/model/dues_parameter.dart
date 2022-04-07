import 'package:equatable/equatable.dart';

class DuesParameter extends Equatable {
  final int month;
  final int year;
  final int limit;

  const DuesParameter({
    this.month = 0,
    this.year = 0,
    this.limit = 20,
  });

  @override
  List<Object> get props => [month, year];

  @override
  String toString() => 'DuesParameter(month: $month, year: $year)';

  DuesParameter copyWith({
    int? month,
    int? year,
  }) {
    return DuesParameter(
      month: month ?? this.month,
      year: year ?? this.year,
    );
  }
}
