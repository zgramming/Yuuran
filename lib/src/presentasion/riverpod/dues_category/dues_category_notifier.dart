import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/dues_category/dues_category_model.dart';
import '../../../domain/repository/dues_repository.dart';

part 'dues_category_state.dart';

class DuesCategoryNotifier extends StateNotifier<DuesCategoryState> {
  DuesCategoryNotifier({required this.repository})
      : super(
          const DuesCategoryState(),
        );

  final DuesRepository repository;

  Future<DuesCategoryState> get() async {
    final result = await repository.getCategory();
    return result.fold(
      (failure) => state = state.init(
        isError: true,
        message: failure.message,
        items: [],
      ),
      (values) => state = state.init(
        isError: false,
        message: null,
        items: values,
      ),
    );
  }

  Future<DuesCategoryState> getByID(int duesCategoryID) async {
    final result = await repository.getCategoryByID(duesCategoryID);

    return result.fold(
      (failure) {
        return state = state.init(
          isError: true,
          item: const DuesCategoryModel(),
          message: failure.message,
        );
      },
      (item) {
        return state = state.init(
          isError: false,
          item: item ?? const DuesCategoryModel(),
        );
      },
    );
  }

  Future<DuesCategoryState> saveDuesCategory({
    int? duesCategoryId,
    required String code,
    required String name,
    required int amount,
    String? description,
  }) async {
    final result = await repository.saveCategory(
      code: code,
      name: name,
      amount: amount,
      description: description,
      duesCategoryId: duesCategoryId,
    );

    return result.fold(
      (failure) => state = state.init(isError: true, message: failure.message),
      (message) => state = state.init(isError: false, message: message),
    );
  }
}

final getDuesCategory = FutureProvider.autoDispose((ref) async {
  final notifier = ref.watch(duesCategoryNotifier.notifier);
  final result = await notifier.get();
  return result;
});

final getDuesCategoryByID =
    FutureProvider.autoDispose.family<DuesCategoryState, int>((ref, duesCategoryID) async {
  final notifier = ref.watch(duesCategoryNotifier.notifier);
  final result = await notifier.getByID(duesCategoryID);
  return result;
});
