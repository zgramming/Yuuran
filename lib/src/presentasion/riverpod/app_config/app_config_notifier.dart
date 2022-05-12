import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/app_config/app_config_model.dart';
import '../../../data/model/user/user_model.dart';
import '../../../utils/utils.dart';

part 'app_config_state.dart';

class AppConfigNotifier extends StateNotifier<AppConfigState> {
  AppConfigNotifier() : super(const AppConfigState()) {
    _init();
  }

  void setState(AppConfigModel Function(AppConfigModel oldValue) value) {
    state = state.copyWith(
      itemAsync: AsyncData(
        value(state.itemAsync.value ?? const AppConfigModel()),
      ),
    );
  }

  Future<bool> _getOnboarding() async {
    final sp = SharedPreferencesUtils.instance;
    return sp.getBool(kOnboardingKey) ?? false;
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

  /// Merge initialize Application into 1 function
  Future<AppConfigState> _init() async {
    state = state.copyWith(itemAsync: const AsyncLoading());
    final onboardingSession = await _getOnboarding();
    final userSession = await _getSessionUser();
    state = state.copyWith(
      itemAsync: AsyncData(
        AppConfigModel(
          alreadyOnboarding: onboardingSession,
          userSession: userSession,
        ),
      ),
    );

    return state;
  }
}

final appConfigInitialize = FutureProvider.autoDispose((ref) async {
  /// Calling [AppConfigNotifier] class
  /// It will automatic calling function in constructor
  ref.watch(appConfigNotifer.notifier);
  return true;
});
