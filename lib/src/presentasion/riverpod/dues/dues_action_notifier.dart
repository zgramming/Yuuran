import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/dues_detail/dues_detail_model.dart';
import '../../../data/model/dues_response/dues_response_model.dart';
import '../../../domain/repository/dues_repository.dart';

part 'dues_action_state.dart';

class DuesActionNotifier extends StateNotifier<DuesActionState> {
  DuesActionNotifier({required this.repository})
      : super(const DuesActionState(saveAsync: AsyncData(null)));
  final DuesRepository repository;

  Future<void> saveDues(
    String duesDetailId, {
    required int duesCategoryId,
    required int usersId,
    required int month,
    required int year,
    required int amount,
    required StatusPaid status,
    required int createdBy,
    String? description,
  }) async {
    state = state.copyWith(saveAsync: const AsyncLoading());
    final result = await repository.saveDues(
      duesDetailId,
      duesCategoryId: duesCategoryId,
      usersId: usersId,
      month: month,
      year: year,
      amount: amount,
      status: status,
      createdBy: createdBy,
      description: description,
    );

    result.fold(
      (failure) => state = state.copyWith(saveAsync: AsyncError(failure.message)),
      (response) => state = state.copyWith(saveAsync: AsyncData(response)),
    );
  }
}

final duesActionNotifier = StateNotifierProvider<DuesActionNotifier, DuesActionState>(
  (ref) => DuesActionNotifier(
    repository: ref.watch(duesRepository),
  ),
);
