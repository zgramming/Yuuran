part of 'app_config_action_notifier.dart';

class AppConfigActionState extends Equatable {
  const AppConfigActionState({
    this.setOnboardingState = const AsyncData(false),
    this.setSessionUserState = const AsyncData(null),
    this.deleteSessionUserState = const AsyncData(false),
  });

  final AsyncValue<bool> setOnboardingState;
  final AsyncValue<UserModel?> setSessionUserState;
  final AsyncValue<bool> deleteSessionUserState;

  @override
  List<Object> get props => [setOnboardingState, setSessionUserState, deleteSessionUserState];

  @override
  String toString() =>
      'AppConfigActionState(setOnboardingState: $setOnboardingState, setSessionUserState: $setSessionUserState, deleteSessionUserState: $deleteSessionUserState)';

  AppConfigActionState copyWith({
    AsyncValue<bool>? setOnboardingState,
    AsyncValue<UserModel?>? setSessionUserState,
    AsyncValue<bool>? deleteSessionUserState,
  }) {
    return AppConfigActionState(
      setOnboardingState: setOnboardingState ?? this.setOnboardingState,
      setSessionUserState: setSessionUserState ?? this.setSessionUserState,
      deleteSessionUserState: deleteSessionUserState ?? this.deleteSessionUserState,
    );
  }
}
