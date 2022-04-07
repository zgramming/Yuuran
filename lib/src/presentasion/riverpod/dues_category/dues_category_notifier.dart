import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/dues_category/dues_category_model.dart';
import '../../../domain/repository/dues_repository.dart';

part 'dues_category_state.dart';

class DuesCategoryNotifier extends StateNotifier<DuesCategoryState> {
  DuesCategoryNotifier({required this.repository}) : super(const DuesCategoryState());

  final DuesRepository repository;

  Future<DuesCategoryState> get() async {
    final result = await repository.getDuesCategory();
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
}

final getDuesCategory = FutureProvider.autoDispose((ref) async {
  final notifier = ref.watch(duesCategoryNotifier.notifier);
  final result = await notifier.get();
  return result;
});
