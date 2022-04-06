import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yuuran/src/utils/constant.dart';
import 'package:yuuran/src/utils/shared_preferences.dart';

class AppConfigModel extends Equatable {
  const AppConfigModel({
    this.alreadyOnboarding = false,
  });

  final bool alreadyOnboarding;

  @override
  List<Object> get props => [alreadyOnboarding];

  @override
  String toString() => 'AppConfigModel(alreadyOnboarding: $alreadyOnboarding)';

  AppConfigModel copyWith({
    bool? alreadyOnboarding,
  }) {
    return AppConfigModel(
      alreadyOnboarding: alreadyOnboarding ?? this.alreadyOnboarding,
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

  return ref.read(appConfigNotifer).item;
});
