import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';

final getDuesCategories = FutureProvider.autoDispose((ref) async {
  final repository = ref.watch(duesRepository);
  final result = await repository.getCategory();
  return result.fold((l) => throw Exception(l.message), (items) => items);
});
