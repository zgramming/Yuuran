part of 'dues_citizen_notifier.dart';

class DuesCitizenState extends Equatable {
  const DuesCitizenState({
    this.items = const [],
    this.isError = false,
    this.message,
  });

  final List<DuesDetailModel> items;
  final bool isError;
  final String? message;

  DuesCitizenState init({
    List<DuesDetailModel> items = const [],
    bool isError = false,
    String? message,
  }) {
    return copyWith(
      items: items,
      isError: isError,
      message: message,
    );
  }

  @override
  List<Object?> get props => [items, isError, message];

  @override
  String toString() => 'DuesState(items: $items, isError: $isError, message: $message)';

  DuesCitizenState copyWith({
    List<DuesDetailModel>? items,
    bool? isError,
    String? message,
  }) {
    return DuesCitizenState(
      items: items ?? this.items,
      isError: isError ?? this.isError,
      message: message ?? this.message,
    );
  }
}
