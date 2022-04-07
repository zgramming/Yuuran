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
        items: [],
        isError: true,
        message: failure.message,
      ),
      (values) => state = state.init(
        isError: false,
        message: null,
        items: values,
      ),
    );
  }
}

final getCitizen = FutureProvider.autoDispose((ref) async {
  final notifier = ref.watch(citizenNotifier.notifier);

  /// Load Citizen from API
  await notifier.get();

  return ref.watch(citizenGrouping);
});

final citizenQuery = StateProvider<String?>((ref) => null);

final citizenGrouping = Provider<Map<String, List<UserModel>>>((ref) {
  final values = ref.watch(citizenNotifier).items;
  if (values.isEmpty) return {};

  final tempMap = <String, List<UserModel>>{};

  for (final value in values) {
    /// Get first character of string
    /// zeffry = z
    /// syarif = s
    final isExists = tempMap[value.name[0]];

    /// Check if key with character is exists or not
    /// if not exist create empty List
    if (isExists == null) tempMap[value.name[0]] = [];

    /// Add user depend of first character
    tempMap[value.name[0]]?.add(value);
  }

  /// Sort By Key
  final sortedByKey = SplayTreeMap<String, List<UserModel>>.from(
    tempMap,
    (key1, key2) => key1.compareTo(key2),
  );

  /// Sort By Values
  final resultMap = <String, List<UserModel>>{};
  for (final key in sortedByKey.keys) {
    sortedByKey[key]?.sort((a, b) => a.name.compareTo(b.name));
    resultMap[key] = sortedByKey[key] ?? [];
  }

  return resultMap;
});

final citizenGroupingFiltered = Provider((ref) {
  final query = ref.watch(citizenQuery);
  final citizen = ref.watch(citizenGrouping);

  /// Flatten Map<String,List<UserModel>> to List<UserModel>
  final flattenCitizen = {for (final item in citizen.values) ...item}.toList();
  if (query == null || query.isEmpty) return flattenCitizen;

  return flattenCitizen.where((element) {
    return element.name.toLowerCase().contains(query.toLowerCase());
  }).toList();
});
