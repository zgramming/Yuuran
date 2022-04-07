import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/dues_citizen_parameter.dart';
import '../../../data/model/dues_detail/dues_detail_model.dart';
import '../../../domain/repository/dues_repository.dart';

part 'dues_citizen_state.dart';

class DuesCitizenNotifier extends StateNotifier<DuesCitizenState> {
  DuesCitizenNotifier({
    required this.repository,
  }) : super(const DuesCitizenState());

  final DuesRepository repository;
  Future<DuesCitizenState> getDuesByUsername({
    required String name,
    int? month,
    int? year,
    int? duesCategoryId,
  }) async {
    final result = await repository.getDuesByUsername(
      name: name,
      duesCategoryId: duesCategoryId,
      month: month,
      year: year,
    );

    return result.fold(
      (failure) {
        return state = state.init(
          isError: true,
          items: [],
          message: failure.message,
        );
      },
      (values) {
        return state = state.init(
          isError: false,
          items: values,
          message: null,
        );
      },
    );
  }
}

final duesCitizenParameter = StateProvider((ref) {
  final now = DateTime.now();
  return DuesCitizenParameter(month: now.month, year: now.year);
});

final getCitizenDues =
    FutureProvider.autoDispose.family<DuesCitizenState, String>((ref, username) async {
  final notifier = ref.watch(duesCitizenNotifier.notifier);
  final parameter = ref.watch(duesCitizenParameter);

  final result = await notifier.getDuesByUsername(
    name: username,
    duesCategoryId: parameter.duesCategory?.id,
    month: parameter.month,
    year: parameter.year,
  );

  return result;
});
