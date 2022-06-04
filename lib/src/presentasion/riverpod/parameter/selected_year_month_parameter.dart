import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/dues_parameter.dart';

final selectedYearMonthParameter = StateProvider.autoDispose(
  (ref) => SelectedMonthYearParameter(month: DateTime.now().month, year: DateTime.now().year),
);
