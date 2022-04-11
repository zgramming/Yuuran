part of 'dues_citizen_notifier.dart';

class DuesCitizenState extends Equatable {
  const DuesCitizenState({
    this.item = const DuesCitizenModel(),
    this.isError = false,
    this.message,
  });

  final DuesCitizenModel item;
  final bool isError;
  final String? message;

  DuesCitizenState init({
    required DuesCitizenModel item,
    bool isError = false,
    String? message,
  }) {
    return copyWith(
      item: item,
      isError: isError,
      message: message,
    );
  }

  @override
  List<Object?> get props => [item, isError, message];

  @override
  String toString() => 'DuesCitizenState(item: $item, isError: $isError, message: $message)';

  DuesCitizenState copyWith({
    DuesCitizenModel? item,
    bool? isError,
    String? message,
  }) {
    return DuesCitizenState(
      item: item ?? this.item,
      isError: isError ?? this.isError,
      message: message ?? this.message,
    );
  }
}
