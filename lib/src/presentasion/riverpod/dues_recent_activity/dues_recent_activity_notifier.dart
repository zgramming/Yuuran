import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/dues_detail/dues_detail_model.dart';
import '../../../domain/repository/dues_repository.dart';
import '../global/global_notifier.dart';

part 'dues_recent_activity_state.dart';

class DuesRecentActivityNotifier extends StateNotifier<DuesRecentActivityState> {
  DuesRecentActivityNotifier({required this.repository}) : super(const DuesRecentActivityState());

  final DuesRepository repository;

  Future<DuesRecentActivityState> get({
    int? month,
    int? year,
    int? limit,
  }) async {
    final result = await repository.getRecentActivity(
      limit: limit,
      month: month,
      year: year,
    );

    return result.fold(
      (failure) => throw state = state.init(
        isError: true,
        items: [],
        message: failure.message,
      ),
      (items) => state = state.init(
        items: items,
        isError: false,
        message: null,
      ),
    );
  }
}

final getDuesRecentActivity = FutureProvider.autoDispose((ref) async {
  final notifier = ref.watch(duesRecentActivityNotifier.notifier);

  final month = ref.watch(duesParameter.select((value) => value.month));
  final year = ref.watch(duesParameter.select((value) => value.year));
  final limit = ref.watch(duesParameter.select((value) => value.limit));

  final result = await notifier.get(
    limit: limit,
    month: month,
    year: year,
  );

  return result;
});
