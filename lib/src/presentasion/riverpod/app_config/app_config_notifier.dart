import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/user/user_model.dart';
import '../../../utils/utils.dart';

class AppConfigModel extends Equatable {
  const AppConfigModel({
    this.alreadyOnboarding = false,
    this.userSession,
  });

  final bool alreadyOnboarding;
  final UserModel? userSession;

  @override
  List<Object?> get props => [alreadyOnboarding, userSession];

  @override
  String toString() =>
      'AppConfigModel(alreadyOnboarding: $alreadyOnboarding, userSession: $userSession)';

  AppConfigModel copyWith({
    bool? alreadyOnboarding,
    UserModel? userSession,
  }) {
    return AppConfigModel(
      alreadyOnboarding: alreadyOnboarding ?? this.alreadyOnboarding,
      userSession: userSession ?? this.userSession,
    );
  }
}

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

class AppConfigState extends Equatable {
  const AppConfigState({
    this.item = const AppConfigModel(),
  });

  final AppConfigModel item;

  AppConfigState setOnboarding(bool alreadyOnboarding) {
    return copyWith(
      item: item.copyWith(alreadyOnboarding: alreadyOnboarding),
    );
  }

  AppConfigState getOnboarding(bool alreadyOnboarding) {
    return copyWith(
      item: item.copyWith(alreadyOnboarding: alreadyOnboarding),
    );
  }

  AppConfigState setUserSession(UserModel? user) {
    return copyWith(item: item.copyWith(userSession: user));
  }

  AppConfigState getUserSession(UserModel? user) {
    return copyWith(item: item.copyWith(userSession: user));
  }

  AppConfigState deleteUserSession() {
    return copyWith(item: item.copyWith(userSession: null));
  }

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'AppConfigState(item: $item)';

  AppConfigState copyWith({
    AppConfigModel? item,
  }) {
    return AppConfigState(
      item: item ?? this.item,
    );
  }
}

final appConfigNotifer =
    StateNotifierProvider<AppConfigNotifier, AppConfigState>((ref) => AppConfigNotifier());

final appConfigInitialize = FutureProvider.autoDispose((ref) async {
  final appNotifier = ref.watch(appConfigNotifer.notifier);

  await appNotifier.getOnboarding();

  await appNotifier.getSessionUser();

  return ref.read(appConfigNotifer).item;
});
