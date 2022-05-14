part of 'app_config_notifier.dart';

class AppConfigState extends Equatable {
  const AppConfigState({
    this.itemAsync = const AsyncData(AppConfigModel()),
  });

  final AsyncValue<AppConfigModel> itemAsync;

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
