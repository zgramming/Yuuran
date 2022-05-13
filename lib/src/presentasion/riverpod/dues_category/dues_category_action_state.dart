part of 'dues_category_action_notifier.dart';

class DuesCategoryActionState extends Equatable {
  const DuesCategoryActionState({
    this.saveAsync = const AsyncData(null),
  });

  final AsyncValue<String?> saveAsync;

  @override
  List<Object> get props => [saveAsync];

  @override
  String toString() => 'DuesCategoryActionState(saveAsync: $saveAsync)';

  DuesCategoryActionState copyWith({
    AsyncValue<String>? saveAsync,
  }) {
    return DuesCategoryActionState(
      saveAsync: saveAsync ?? this.saveAsync,
    );
  }
}
