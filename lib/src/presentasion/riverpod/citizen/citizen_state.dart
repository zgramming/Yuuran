part of 'citizen_notifier.dart';

class CitizenState extends Equatable {
  const CitizenState({
    this.items = const [],
    this.item = const UserModel(),
    this.isError = false,
    this.message,
  });

  final List<UserModel> items;
  final UserModel item;
  final bool isError;
  final String? message;

  @override
  List<Object?> get props => [items, item, isError, message];

  @override
  String toString() {
    return 'CitizenState(items: $items, item: $item, isError: $isError, message: $message)';
  }

  CitizenState copyWith({
    List<UserModel>? items,
    UserModel? item,
    bool? isError,
    String? message,
  }) {
    return CitizenState(
      items: items ?? this.items,
      item: item ?? this.item,
      isError: isError ?? this.isError,
      message: message ?? this.message,
    );
  }
}
