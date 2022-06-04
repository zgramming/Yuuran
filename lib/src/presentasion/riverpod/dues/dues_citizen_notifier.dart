import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/dues_citizen/dues_citizen_model.dart';
import '../parameter/dues_citizen_parameter.dart';

final getCitizenDues =
    FutureProvider.autoDispose.family<DuesCitizenModel, String>((ref, username) async {
  final repository = ref.watch(duesRepository);
  final parameter = ref.watch(duesCitizenParameter);

  final result = await repository.getByUsername(
    name: username,
    duesCategoryId: parameter.duesCategory?.id,
    month: parameter.month,
    year: parameter.year,
  );

  return result.fold((failure) => throw Exception(failure.message), (item) => item);
});
