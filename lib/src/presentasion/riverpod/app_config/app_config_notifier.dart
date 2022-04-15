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

  Future<AppConfigState> setOnboarding(bool value) async {
    final sp = SharedPreferencesUtils.instance;
    await sp.setBool(kOnboardingKey, value);
    state = state.setOnboarding(value);
    return state;
  }

  Future<bool> _getOnboarding() async {
    final sp = SharedPreferencesUtils.instance;
    return sp.getBool(kOnboardingKey) ?? false;
  }

  Future<AppConfigState> setSessionUser(UserModel? user) async {
    final sp = SharedPreferencesUtils.instance;
    await sp.setString(kUserKey, jsonEncode(user?.toJson()));
    state = state.setUserSession(user);
    return state;
  }

  Future<UserModel?> _getSessionUser() async {
    final sp = SharedPreferencesUtils.instance;

    /// JsonEncode
    final encodedUser = sp.getString(kUserKey);
    if (encodedUser == null) {
      return null;
    }

    final decoded = jsonDecode(encodedUser);
    final user = UserModel.fromJson(decoded as Map<String, dynamic>);
    return user;
  }

  Future<AppConfigState> deleteUserSession() async {
    final sp = SharedPreferencesUtils.instance;
    await sp.remove(kUserKey);
    state = state.deleteUserSession();
    return state;
  }

  /// Merge initialize Application into 1 function
  Future<AppConfigState> init() async {
    final onboardingSession = await _getOnboarding();
    final userSession = await _getSessionUser();

    state = state.copyWith(
      item: state.item.copyWith(
        alreadyOnboarding: onboardingSession,
        userSession: userSession,
      ),
    );
    return state;
  }
}

final appConfigInitialize = FutureProvider.autoDispose((ref) async {
  final appNotifier = ref.watch(appConfigNotifer.notifier);
  final result = await appNotifier.init();
  return result;
});
