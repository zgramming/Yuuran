import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/dues_category/dues_category_model.dart';

final getDuesCategoryByID =
    FutureProvider.autoDispose.family<DuesCategoryModel?, int>((ref, duesCategoryID) async {
  final repository = ref.watch(duesRepository);
  final result = await repository.getCategoryByID(duesCategoryID);
  return result.fold((l) => throw Exception(l.message), (item) => item);
});
