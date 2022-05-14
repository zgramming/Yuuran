import 'package:equatable/equatable.dart';

import '../user/user_model.dart';

class AuthenticationResponse extends Equatable {
  const AuthenticationResponse({
    required this.token,
    required this.user,
    required this.message,
  });

  final String token;
  final UserModel user;
  final String message;

  @override
  List<Object> get props => [token, user, message];

  @override
  String toString() => 'AuthenticationResponse(token: $token, user: $user, message: $message)';

  AuthenticationResponse copyWith({
    String? token,
    UserModel? user,
    String? message,
  }) {
    return AuthenticationResponse(
      token: token ?? this.token,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }
}
