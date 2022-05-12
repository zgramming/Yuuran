import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/user/user_model.dart';
import '../../../utils/utils.dart';

part 'app_config_action_state.dart';

class AppConfigActionNotifier extends StateNotifier<AppConfigActionState> {
  AppConfigActionNotifier({required this.read}) : super(const AppConfigActionState());

  final Reader read;

  Future setOnboarding(bool value) async {
    final sp = SharedPreferencesUtils.instance;

    state = state.copyWith(setOnboardingState: const AsyncLoading());
    await sp.setBool(kOnboardingKey, value);
    state = state.copyWith(setOnboardingState: AsyncData(value));

    /// Update state [app config notifier]
    read(appConfigNotifer.notifier)
        .setState((oldValue) => oldValue.copyWith(alreadyOnboarding: value));
  }

  Future setSessionUser(UserModel? user) async {
    final sp = SharedPreferencesUtils.instance;

    state = state.copyWith(setSessionUserState: const AsyncLoading());
    await sp.setString(kUserKey, jsonEncode(user?.toJson()));
    state = state.copyWith(setSessionUserState: AsyncData(user));

    /// Update state [app config notifier]
    read(appConfigNotifer.notifier).setState((oldValue) => oldValue.copyWith(userSession: user));
  }

  Future deleteSessionUser() async {
    final sp = SharedPreferencesUtils.instance;
    state = state.copyWith(deleteSessionUserState: const AsyncLoading());
    await sp.remove(kUserKey);
    state = state.copyWith(deleteSessionUserState: const AsyncData(true));

    /// Update state [app config notifier]
    read(appConfigNotifer.notifier)
        .setState((oldValue) => oldValue.copyWith(userSession: const UserModel()));
  }
}

final appConfigActionNotifier =
    StateNotifierProvider<AppConfigActionNotifier, AppConfigActionState>(
  (ref) => AppConfigActionNotifier(read: ref.read),
);
