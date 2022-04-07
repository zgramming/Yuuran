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

enum StatusActive { active, notActive, none }
enum StatusPayment { paidOff, notPaidOff, none }

class DuesCategory extends Equatable {
  const DuesCategory({
    this.id = 0,
    this.code = '',
    this.name = '',
    this.description,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  final int id;
  final String code;
  final String name;
  final String? description;
  final StatusActive status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? createdBy;
  final int? updatedBy;

  @override
  List<Object?> get props {
    return [
      id,
      code,
      name,
      description,
      status,
      createdAt,
      updatedAt,
      createdBy,
      updatedBy,
    ];
  }

  @override
  String toString() {
    return 'DuesCategory(id: $id, code: $code, name: $name, description: $description, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy)';
  }

  DuesCategory copyWith({
    int? id,
    String? code,
    String? name,
    String? description,
    StatusActive? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? createdBy,
    int? updatedBy,
  }) {
    return DuesCategory(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}

class Dues extends Equatable {
  const Dues({
    this.id = 0,
    required this.citizen,
    this.name = '',
    required this.date,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  final int id;
  final User citizen;
  final String name;
  final DateTime date;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? createdBy;
  final int? updatedBy;

  @override
  List<Object?> get props {
    return [
      id,
      citizen,
      name,
      date,
      createdAt,
      updatedAt,
      createdBy,
      updatedBy,
    ];
  }

  @override
  String toString() {
    return 'Dues(id: $id, citizen: $citizen, name: $name, date: $date, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy)';
  }

  Dues copyWith({
    int? id,
    User? citizen,
    String? name,
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? createdBy,
    int? updatedBy,
  }) {
    return Dues(
      id: id ?? this.id,
      citizen: citizen ?? this.citizen,
      name: name ?? this.name,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}

class DuesDetail extends Equatable {
  const DuesDetail({
    this.id = 0,
    required this.dues,
    required this.duesCategory,
    required this.citizen,
    this.amount = 0.0,
    required this.status,
    this.paidBySomeoneElse = false,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  final int id;
  final Dues dues;
  final DuesCategory duesCategory;
  final User citizen;
  final double amount;
  final StatusPayment status;
  final bool paidBySomeoneElse;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? createdBy;
  final int? updatedBy;

  @override
  List<Object?> get props {
    return [
      id,
      dues,
      duesCategory,
      citizen,
      amount,
      status,
      paidBySomeoneElse,
      description,
      createdAt,
      updatedAt,
      createdBy,
      updatedBy,
    ];
  }

  @override
  String toString() {
    return 'DuesDetail(id: $id, dues: $dues, duesCategory: $duesCategory, citizen: $citizen, amount: $amount, status: $status, paidBySomeoneElse: $paidBySomeoneElse, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy)';
  }

  DuesDetail copyWith({
    int? id,
    Dues? dues,
    DuesCategory? duesCategory,
    User? citizen,
    double? amount,
    StatusPayment? status,
    bool? paidBySomeoneElse,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? createdBy,
    int? updatedBy,
  }) {
    return DuesDetail(
      id: id ?? this.id,
      dues: dues ?? this.dues,
      duesCategory: duesCategory ?? this.duesCategory,
      citizen: citizen ?? this.citizen,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      paidBySomeoneElse: paidBySomeoneElse ?? this.paidBySomeoneElse,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}

class AppGroupUser extends Equatable {
  const AppGroupUser({
    this.id = 0,
    this.code = '',
    this.name = '',
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  final int id;
  final String code;
  final String name;
  final StatusActive status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? createdBy;
  final int? updatedBy;

  @override
  List<Object?> get props {
    return [
      id,
      code,
      name,
      status,
      createdAt,
      updatedAt,
      createdBy,
      updatedBy,
    ];
  }

  @override
  String toString() {
    return 'AppGroupUser(id: $id, code: $code, name: $name, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy)';
  }

  AppGroupUser copyWith({
    int? id,
    String? code,
    String? name,
    StatusActive? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? createdBy,
    int? updatedBy,
  }) {
    return AppGroupUser(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}

class User extends Equatable {
  const User({
    this.id = 0,
    required this.appGroupUser,
    this.username = '',
    this.name = '',
    this.email = '',
    required this.status,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  final int id;
  final AppGroupUser appGroupUser;
  final String username;
  final String name;
  final String email;
  final StatusActive status;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? createdBy;
  final int? updatedBy;

  @override
  List<Object?> get props {
    return [
      id,
      appGroupUser,
      username,
      name,
      email,
      status,
      profileImage,
      createdAt,
      updatedAt,
      createdBy,
      updatedBy,
    ];
  }

  @override
  String toString() {
    return 'User(id: $id, appGroupUser: $appGroupUser, username: $username, name: $name, email: $email, status: $status, profileImage: $profileImage, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy)';
  }

  User copyWith({
    int? id,
    AppGroupUser? appGroupUser,
    String? username,
    String? name,
    String? email,
    StatusActive? status,
    String? profileImage,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? createdBy,
    int? updatedBy,
  }) {
    return User(
      id: id ?? this.id,
      appGroupUser: appGroupUser ?? this.appGroupUser,
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      status: status ?? this.status,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}
