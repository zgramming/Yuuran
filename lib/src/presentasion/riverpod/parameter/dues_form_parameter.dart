import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/dues_form_parameter.dart';

final duesFormParameter = StateProvider.autoDispose((ref) {
  final now = DateTime.now();
  return DuesFormParameter(month: now.month, year: now.year);
});
