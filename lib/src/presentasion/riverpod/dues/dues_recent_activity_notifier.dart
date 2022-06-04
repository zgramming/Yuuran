import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../parameter/selected_year_month_parameter.dart';

final getDuesRecentActivity = FutureProvider.autoDispose((ref) async {
  final repository = ref.watch(duesRepository);
  final parameter = ref.watch(selectedYearMonthParameter);
  final result = await repository.getRecentActivity(
    limit: parameter.limit,
    month: parameter.month,
    year: parameter.year,
  );

  return result.fold((failure) => throw Exception(failure.message), (items) => items);
});
