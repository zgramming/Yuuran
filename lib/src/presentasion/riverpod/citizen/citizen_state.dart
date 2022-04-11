part of 'citizen_notifier.dart';

class CitizenState extends Equatable {
  const CitizenState({
    this.items = const [],
    this.isError = false,
    this.message,
  });

  final List<UserModel> items;
  final bool isError;
  final String? message;

  CitizenState init({
    required List<UserModel> items,
    bool isError = false,
    String? message,
  }) {
    return copyWith(
      isError: isError,
      items: items,
      message: message,
    );
  }

  @override
  List<Object?> get props => [items, isError, message];

  @override
  String toString() => 'CitizenState(items: $items, isError: $isError, message: $message)';

  CitizenState copyWith({
    List<UserModel>? items,
    bool? isError,
    String? message,
  }) {
    return CitizenState(
      items: items ?? this.items,
      isError: isError ?? this.isError,
      message: message ?? this.message,
    );
  }
}
