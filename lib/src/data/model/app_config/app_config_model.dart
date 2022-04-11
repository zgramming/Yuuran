import 'package:equatable/equatable.dart';

import '../user/user_model.dart';

class AppConfigModel extends Equatable {
  const AppConfigModel({
    this.alreadyOnboarding = false,
    this.userSession,
  });

  final bool alreadyOnboarding;
  final UserModel? userSession;

  @override
  List<Object?> get props => [alreadyOnboarding, userSession];

  @override
  String toString() =>
      'AppConfigModel(alreadyOnboarding: $alreadyOnboarding, userSession: $userSession)';

  AppConfigModel copyWith({
    bool? alreadyOnboarding,
    UserModel? userSession,
  }) {
    return AppConfigModel(
      alreadyOnboarding: alreadyOnboarding ?? this.alreadyOnboarding,
      userSession: userSession ?? this.userSession,
    );
  }
}
