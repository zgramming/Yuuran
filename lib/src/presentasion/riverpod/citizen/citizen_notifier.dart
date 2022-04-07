import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/user/user_model.dart';
import '../../../domain/repository/citizen_repository.dart';

part 'citizen_state.dart';

class CitizenNotifier extends StateNotifier<CitizenState> {
  CitizenNotifier({
    required this.repository,
  }) : super(const CitizenState());

  final CitizenRepository repository;
  Future<CitizenState> get() async {
    final result = await repository.get();
    return result.fold(
      (failure) => state = state.init(
        values: [],
        isError: true,
        message: failure.message,
      ),
      (values) => state = state.init(
        isError: false,
        message: null,
        values: values,
      ),
    );
  }
}

final getCitizen = FutureProvider.autoDispose((ref) async {
  final notifier = ref.watch(citizenNotifier.notifier);

  final result = await notifier.get();
  return result;
});

final citizenQuery = StateProvider<String?>((ref) => null);

final citizenFiltered = Provider((ref) {
  final query = ref.watch(citizenQuery);
  final citizen = ref.watch(citizenNotifier).maps;

  /// Flatten Map<String,List<UserModel>> to List<UserModel>
  final flattenCitizen = {for (final item in citizen.values) ...item}.toList();
  if (query == null || query.isEmpty) return flattenCitizen;

  return flattenCitizen.where((element) {
    return element.name.toLowerCase().contains(query.toLowerCase());
  }).toList();
});
