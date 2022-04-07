import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/dues_parameter.dart';

final duesParameter = StateProvider(
  (ref) => DuesParameter(
    month: DateTime.now().month,
    year: DateTime.now().year,
  ),
);
