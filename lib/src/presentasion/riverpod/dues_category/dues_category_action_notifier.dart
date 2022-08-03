import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../domain/repository/dues_repository.dart';
part 'dues_category_action_state.dart';

class DuesCategoryActionNotifier extends StateNotifier<DuesCategoryActionState> {
  DuesCategoryActionNotifier({required this.repository}) : super(const DuesCategoryActionState());

  final DuesRepository repository;

  Future<void> saveDuesCategory({
    int? duesCategoryId,
    required String code,
    required String name,
    required int amount,
    String? description,
  }) async {
    state = state.copyWith(saveAsync: const AsyncLoading());
    final result = await repository.saveCategory(
      code: code,
      name: name,
      amount: amount,
      description: description,
      duesCategoryId: duesCategoryId,
    );

    result.fold(
      (l) => state = state.copyWith(saveAsync: AsyncError(l.message)),
      (r) => state = state.copyWith(
        saveAsync: AsyncData("Berhasil tambah kategori dengan nama $name"),
      ),
    );
  }
}

final duesCategoryActionNotifier =
    StateNotifierProvider<DuesCategoryActionNotifier, DuesCategoryActionState>(
  (ref) => DuesCategoryActionNotifier(repository: ref.watch(duesRepository)),
);
