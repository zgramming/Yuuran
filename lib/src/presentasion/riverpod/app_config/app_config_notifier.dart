import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/app_config/app_config_model.dart';
import '../../../data/model/user/user_model.dart';
import '../../../utils/utils.dart';

part 'app_config_state.dart';

class AppConfigNotifier extends StateNotifier<AppConfigState> {
  AppConfigNotifier() : super(const AppConfigState());

  Future<void> setOnboarding(bool value) async {
    final sp = SharedPreferencesUtils.instance;
    await sp.setBool(kOnboardingKey, value);
    state = state.setOnboarding(value);
  }

  Future<void> getOnboarding() async {
    final sp = SharedPreferencesUtils.instance;
    state = state.setOnboarding((sp.getBool(kOnboardingKey)) ?? false);
  }

  Future<void> setSessionUser(UserModel? user) async {
    final sp = SharedPreferencesUtils.instance;
    await sp.setString(kUserKey, jsonEncode(user?.toJson()));
    state = state.setUserSession(user);
  }

  Future<void> getSessionUser() async {
    final sp = SharedPreferencesUtils.instance;

    /// JsonEncode
    final encodedUser = sp.getString(kUserKey);
    if (encodedUser == null) {
      state = state.setUserSession(null);
      return;
    }

    final decoded = jsonDecode(encodedUser);
    final user = UserModel.fromJson(decoded as Map<String, dynamic>);
    state = state.setUserSession(user);
  }

  Future<void> deleteUserSession() async {
    final sp = SharedPreferencesUtils.instance;
    await sp.remove(kUserKey);
    state = state.deleteUserSession();
  }
}

final appConfigInitialize = FutureProvider.autoDispose((ref) async {
  final appNotifier = ref.watch(appConfigNotifer.notifier);

  await appNotifier.getOnboarding();

  await appNotifier.getSessionUser();

  return ref.read(appConfigNotifer).item;
});
