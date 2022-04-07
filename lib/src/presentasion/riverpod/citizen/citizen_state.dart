part of 'citizen_notifier.dart';

class CitizenState extends Equatable {
  const CitizenState({
    this.maps = const {},
    this.isError = false,
    this.message,
  });

  final Map<String, List<UserModel>> maps;
  final bool isError;
  final String? message;

  CitizenState init({
    List<UserModel> values = const [],
    bool isError = false,
    String? message,
  }) {
    if (values.isEmpty) return copyWith();

    final tempMap = <String, List<UserModel>>{};

    for (final value in values) {
      /// Get first character of string
      /// zeffry = z
      /// syarif = s
      final isExists = tempMap[value.name[0]];

      /// Check if key with character is exists or not
      /// if not exist create empty List
      if (isExists == null) tempMap[value.name[0]] = [];

      /// Add user depend of first character
      tempMap[value.name[0]]?.add(value);
    }

    /// Sort By Key
    final sortedByKey = SplayTreeMap<String, List<UserModel>>.from(
      tempMap,
      (key1, key2) => key1.compareTo(key2),
    );

    /// Sort By Values
    final resultMap = <String, List<UserModel>>{};
    for (final key in sortedByKey.keys) {
      sortedByKey[key]?.sort((a, b) => a.name.compareTo(b.name));
      resultMap[key] = sortedByKey[key] ?? [];
    }

    return copyWith(
      maps: resultMap,
      isError: isError,
      message: message,
    );
  }

  @override
  List<Object?> get props => [maps, isError, message];

  @override
  String toString() => 'CitizenState(maps: $maps, isError: $isError, message: $message)';

  CitizenState copyWith({
    Map<String, List<UserModel>>? maps,
    bool? isError,
    String? message,
  }) {
    return CitizenState(
      maps: maps ?? this.maps,
      isError: isError ?? this.isError,
      message: message ?? this.message,
    );
  }
}
