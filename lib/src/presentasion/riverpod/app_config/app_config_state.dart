part of 'app_config_notifier.dart';

class AppConfigState extends Equatable {
  const AppConfigState({
    this.itemAsync = const AsyncData(AppConfigModel()),
  });

  final AsyncValue<AppConfigModel> itemAsync;

  // AppConfigState setOnboarding(bool alreadyOnboarding) {
  //   return copyWith(
  //     item: item.copyWith(alreadyOnboarding: alreadyOnboarding),
  //   );
  // }

  // AppConfigState getOnboarding(bool alreadyOnboarding) {
  //   return copyWith(
  //     item: item.copyWith(alreadyOnboarding: alreadyOnboarding),
  //   );
  // }

  // AppConfigState setUserSession(UserModel? user) {
  //   return copyWith(item: item.copyWith(userSession: user));
  // }

  // AppConfigState getUserSession(UserModel? user) {
  //   return copyWith(item: item.copyWith(userSession: user));
  // }

  // AppConfigState deleteUserSession() {
  //   return copyWith(item: item.copyWith(userSession: const UserModel()));
  // }

  @override
  List<Object> get props => [itemAsync];

  @override
  String toString() => 'AppConfigState(itemAsync: $itemAsync)';

  AppConfigState copyWith({
    AsyncValue<AppConfigModel>? itemAsync,
  }) {
    return AppConfigState(
      itemAsync: itemAsync ?? this.itemAsync,
    );
  }
}
