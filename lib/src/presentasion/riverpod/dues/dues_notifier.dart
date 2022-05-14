import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/dues_detail/dues_detail_model.dart';

final getDuesDetail =
    FutureProvider.autoDispose.family<DuesDetailModel?, String>((ref, duesId) async {
  final repository = ref.watch(duesRepository);
  final result = await repository.getDetailByID(duesId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (item) => item,
  );
});
