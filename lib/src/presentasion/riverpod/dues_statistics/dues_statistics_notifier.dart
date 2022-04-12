import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/dues_statistics/dues_statistics_model.dart';
import '../../../domain/repository/dues_repository.dart';
import '../global/global_notifier.dart';

part 'dues_statistics_state.dart';

class DuesStatisticsNotifier extends StateNotifier<DuesStatisticsState> {
  DuesStatisticsNotifier({
    required this.repository,
  }) : super(const DuesStatisticsState());

  final DuesRepository repository;

  Future<DuesStatisticsState> get({
    int? month,
    int? year,
  }) async {
    final result = await repository.getStatistics(month: month, year: year);
    return result.fold(
      (failure) => throw state = state.init(
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

final getDuesStatistics = FutureProvider.autoDispose((ref) async {
  final notifier = ref.watch(duesStatisticsNotifier.notifier);

  /// Only trigger rebuild when month / year changed
  final month = ref.watch(duesParameter.select((value) => value.month));
  final year = ref.watch(duesParameter.select((value) => value.year));
  final result = await notifier.get(month: month, year: year);
  return result;
});
