import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'src/app.dart';
import 'src/utils/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  /// Initialize SharedPreferences Utils
  await SharedPreferencesUtils.init();

  // turn off the # in the URLs on the web
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

// @immutable
// @JsonSerializable(fieldRename: FieldRename.snake)

// class SalesModel extends Equatable{

// }
// @JsonKey(
//     toJson: GlobalFunction.toJsonStringFromInteger,
//     fromJson: GlobalFunction.fromJsonStringToInteger,
//   )

// factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
// Map<String, dynamic> toJson() => _$UserModelToJson(this);
