part of 'user_notifier.dart';

class UserState extends Equatable {
  const UserState({
    this.item,
    this.message = '',
    this.isError = false,
  });

  final UserModel? item;
  final String message;
  final bool isError;

  UserState setUser({
    UserModel? user,
    String? message,
    bool isError = false,
  }) {
    return copyWith(
      item: user,
      message: message,
      isError: isError,
    );
  }

  @override
  List<Object?> get props => [item, message, isError];

  UserState copyWith({
    UserModel? item,
    String? message,
    bool? isError,
  }) {
    return UserState(
      item: item ?? this.item,
      message: message ?? this.message,
      isError: isError ?? this.isError,
    );
  }

  @override
  String toString() => 'UserState(item: $item, message: $message, isError: $isError)';
}
