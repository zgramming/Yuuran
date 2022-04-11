part of 'app_config_notifier.dart';

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
