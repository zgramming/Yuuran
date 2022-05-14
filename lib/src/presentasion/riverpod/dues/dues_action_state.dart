part of 'dues_action_notifier.dart';

class DuesActionState extends Equatable {
  final AsyncValue<DuesResponse?> saveAsync;
  const DuesActionState({
    required this.saveAsync,
  });

  @override
  List<Object> get props => [saveAsync];

  @override
  String toString() => 'DuesActionState(saveAsync: $saveAsync)';

  DuesActionState copyWith({
    AsyncValue<DuesResponse?>? saveAsync,
  }) {
    return DuesActionState(
      saveAsync: saveAsync ?? this.saveAsync,
    );
  }
}
