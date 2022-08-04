import 'dart:collection';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/user/user_model.dart';

final getCitizens = FutureProvider.autoDispose((ref) async {
  final repository = ref.watch(citizenRepository);
  final result = await repository.get();
  return result.fold((l) => throw Exception(l.message), (r) => r);
});

final citizenQuery = StateProvider<String?>((ref) => null);

final citizenGrouping = FutureProvider.autoDispose<Map<String, List<UserModel>>>((ref) async {
  final values = await ref.watch(getCitizens.future);

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

final citizenGroupingFiltered = FutureProvider.autoDispose((ref) async {
  final query = ref.watch(citizenQuery);
  final citizen = await ref.watch(citizenGrouping.future);

  /// Flatten Map<String,List<UserModel>> to List<UserModel>
  final flattenCitizen = {for (final item in citizen.values) ...item}.toList();
  if (query == null || query.isEmpty) return flattenCitizen;

  return flattenCitizen.where((element) {
    return element.name.toLowerCase().contains(query.toLowerCase());
  }).toList();
});
