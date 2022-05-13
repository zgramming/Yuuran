import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../parameter/parameter_notifier.dart';

final getDuesRecentActivity = FutureProvider.autoDispose((ref) async {
  final repository = ref.watch(duesRepository);

  final month = ref.watch(selectedYearMonthParameter.select((value) => value.month));
  final year = ref.watch(selectedYearMonthParameter.select((value) => value.year));
  final limit = ref.watch(selectedYearMonthParameter.select((value) => value.limit));

  final result = await repository.getRecentActivity(
    limit: limit,
    month: month,
    year: year,
  );

  return result.fold((l) => throw Exception(l.message), (r) => r);
});
