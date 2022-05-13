import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_config_notifier.dart';

final appInitialize = FutureProvider.autoDispose((ref) async {
  /// Calling [AppConfigNotifier] class
  /// It will automatic calling function in constructor
  ref.watch(appConfigNotifer.notifier);
  return true;
});
