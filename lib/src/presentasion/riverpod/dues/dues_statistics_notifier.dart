import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../parameter/selected_year_month_parameter.dart';

final getDuesStatistics = FutureProvider.autoDispose((ref) async {
  final repository = ref.watch(duesRepository);

  final param = ref.watch(selectedYearMonthParameter);
  final result = await repository.getStatistics(month: param.month, year: param.year);
  return result.fold((failure) => throw Exception(failure.message), (items) => items);
});

final duesStatisticsSummary = Provider.autoDispose.family<int, int>((ref, duesCategoryId) {
  final items = ref.watch(getDuesStatistics).value!;
  final category = items.duesCategory.firstWhere((element) => element.id == duesCategoryId);
  return category.duesDetail
      .map((d) => d.amount)
      .fold<int>(0, (previousValue, element) => previousValue + element);
});
