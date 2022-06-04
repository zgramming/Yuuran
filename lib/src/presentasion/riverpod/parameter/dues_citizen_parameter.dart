import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/dues_citizen_parameter.dart';

final duesCitizenParameter = StateProvider.autoDispose((ref) {
  final now = DateTime.now();
  return DuesCitizenParameter(month: now.month, year: now.year);
});
