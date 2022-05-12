part of 'authentication_notifier.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    required this.authenticationAsync,
  });
  final AsyncValue<AuthenticationResponse?> authenticationAsync;

  @override
  List<Object> get props => [authenticationAsync];

  AuthenticationState copyWith({
    AsyncValue<AuthenticationResponse>? authenticationAsync,
  }) {
    return AuthenticationState(
      authenticationAsync: authenticationAsync ?? this.authenticationAsync,
    );
  }

  @override
  String toString() => 'AuthenticationState(authenticationAsync: $authenticationAsync)';
}
