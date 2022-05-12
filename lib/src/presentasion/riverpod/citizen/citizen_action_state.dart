part of 'citizen_action_notifier.dart';

class CitizenActionState extends Equatable {
  const CitizenActionState({
    this.saveAsync = const AsyncData(""),
  });

  final AsyncValue<String> saveAsync;

  @override
  List<Object> get props => [saveAsync];

  @override
  String toString() => 'CitizenActionState(saveAsync: $saveAsync)';

  CitizenActionState copyWith({
    AsyncValue<String>? saveAsync,
  }) {
    return CitizenActionState(
      saveAsync: saveAsync ?? this.saveAsync,
    );
  }
}
