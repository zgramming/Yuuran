import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/dues_parameter.dart';
import '../../../data/model/dues_statistics/dues_statistics_model.dart';
import '../../../domain/repository/dues_statistics_repository.dart';

part 'dues_statistics_state.dart';

class DuesStatisticsNotifier extends StateNotifier<DuesStatisticsState> {
  DuesStatisticsNotifier({
    required this.repository,
  }) : super(const DuesStatisticsState());

  final DuesStatisticsRepository repository;

  Future<DuesStatisticsState> get({
    int? month,
    int? year,
  }) async {
    final result = await repository.get(month: month, year: year);
    return result.fold(
      (failure) => state = state.init(
        value: null,
        isError: true,
        message: failure.message,
      ),
      (value) {
        return state = state.init(
          value: value,
          isError: false,
          message: null,
        );
      },
    );
  }
}

final duesParameter = StateProvider(
  (ref) => DuesParameter(
    month: DateTime.now().month,
    year: DateTime.now().year,
  ),
);

final getDuesStatistics = FutureProvider.autoDispose((ref) async {
  final notifier = ref.watch(duesStatisticsNotifier.notifier);
  final params = ref.watch(duesParameter);
  final result = await notifier.get(month: params.month, year: params.year);
  return result;
});
