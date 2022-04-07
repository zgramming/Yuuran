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

  // CitizenState init({
  //   List<UserModel> values = const [],
  //   bool isError = false,
  //   String? message,
  // }) {
  //   if (values.isEmpty) return copyWith();

  //   final tempMap = <String, List<UserModel>>{};

  //   for (final value in values) {
  //     /// Get first character of string
  //     /// zeffry = z
  //     /// syarif = s
  //     final isExists = tempMap[value.name[0]];

  //     /// Check if key with character is exists or not
  //     /// if not exist create empty List
  //     if (isExists == null) tempMap[value.name[0]] = [];

  //     /// Add user depend of first character
  //     tempMap[value.name[0]]?.add(value);
  //   }

  //   /// Sort By Key
  //   final sortedByKey = SplayTreeMap<String, List<UserModel>>.from(
  //     tempMap,
  //     (key1, key2) => key1.compareTo(key2),
  //   );

  //   /// Sort By Values
  //   final resultMap = <String, List<UserModel>>{};
  //   for (final key in sortedByKey.keys) {
  //     sortedByKey[key]?.sort((a, b) => a.name.compareTo(b.name));
  //     resultMap[key] = sortedByKey[key] ?? [];
  //   }

  //   return copyWith(
  //     maps: resultMap,
  //     isError: isError,
  //     message: message,
  //   );
  // }

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
