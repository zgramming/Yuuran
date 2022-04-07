import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'src/utils/shared_preferences.dart';

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  /// Initialize SharedPreferences Utils
  await SharedPreferencesUtils.init();

  // turn off the # in the URLs on the web
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

// @immutable
// @JsonSerializable(fieldRename: FieldRename.snake)

// class SalesModel extends Equatable{

// }
// @JsonKey(
//     toJson: GlobalFunction.toJsonStringFromInteger,
//     fromJson: GlobalFunction.fromJsonStringToInteger,
//   )

// factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
// Map<String, dynamic> toJson() => _$UserModelToJson(this);

class Person extends Equatable {
  const Person({
    this.name = '',
  });

  final String name;

  @override
  List<Object> get props => [name];

  Person copyWith({
    String? name,
  }) {
    return Person(
      name: name ?? this.name,
    );
  }

  static const persons = [
    Person(name: "Zeffry Reynando"),
    Person(name: "Helmi Aji Hamamamiardi"),
    Person(name: "Syarif Hidayatulllah"),
    Person(name: "Umar Bawazir"),
    Person(name: "Anggit PP"),
    Person(name: "Rifda Kamila"),
    Person(name: "Nakia"),
    Person(name: "Caul"),
    Person(name: "Ruth"),
    Person(name: "Cindy"),
    Person(name: "Rangga"),
    Person(name: "Andi S"),
    Person(name: "Engkoh"),
  ];
}

class MyEvent extends Equatable {
  const MyEvent({
    this.title = '',
  });

  final String title;

  @override
  List<Object> get props => [title];

  @override
  String toString() => 'MyEvent(title: $title)';

  MyEvent copyWith({
    String? title,
  }) {
    return MyEvent(
      title: title ?? this.title,
    );
  }

  static const myEvents = <MyEvent>[
    MyEvent(title: "Event 1"),
    MyEvent(title: "Event 2"),
    MyEvent(title: "Event 3"),
  ];
}
