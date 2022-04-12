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
      (failure) => throw state = state.copyWith(
        items: [],
        isError: true,
        message: failure.message,
      ),
      (values) => state = state.copyWith(
        isError: false,
        message: null,
        items: values,
      ),
    );
  }

  Future<CitizenState> getByID(int id) async {
    final result = await repository.getByID(id);
    return result.fold(
      (failure) => state = state.copyWith(
        isError: true,
        item: const UserModel(),
        message: failure.message,
      ),
      (value) => state = state.copyWith(
        isError: false,
        item: value,
      ),
    );
  }

  Future<CitizenState> saveCitizen({
    required int? id,
    required String username,
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final result = await repository.saveCitizen(
      id: id,
      username: username,
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );

    return result.fold(
      (failure) => state = state.copyWith(message: failure.message, isError: true),
      (message) => state = state.copyWith(message: message, isError: false),
    );
  }
}

final getCitizen = FutureProvider.autoDispose((ref) async {
  final notifier = ref.watch(citizenNotifier.notifier);

  /// Load Citizen from API
  final result = await notifier.get();

  return result;
});

final getCitizenGrouping = FutureProvider.autoDispose((ref) async {
  final notifier = ref.watch(citizenNotifier.notifier);

  /// Load Citizen from API
  await notifier.get();

  return ref.read(citizenGrouping);
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
