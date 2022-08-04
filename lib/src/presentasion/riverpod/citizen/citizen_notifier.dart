import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/user/user_model.dart';

final getCitizenById = FutureProvider.autoDispose.family<UserModel?, int>((ref, id) async {
  final repo = ref.watch(citizenRepository);
  final result = await repo.getByID(id);
  return result.fold((l) => throw Exception(l.message), (r) => r);
});
