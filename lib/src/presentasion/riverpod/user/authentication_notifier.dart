import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/authentication/authentication_response.dart';
import '../../../domain/repository/authentication_repository.dart';
import '../app_config/app_config_action_notifier.dart';

part 'authentication_state.dart';

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  AuthenticationNotifier({
    required this.repository,
    required this.read,
  }) : super(const AuthenticationState(authenticationAsync: AsyncData(null)));

  final AuthenticationRepository repository;
  final Reader read;

  Future<AuthenticationState> login({
    required String username,
    required String password,
  }) async {
    state = state.copyWith(authenticationAsync: const AsyncLoading());
    final result = await repository.login(username: username, password: password);

    return result.fold(
      (failure) => state = state.copyWith(authenticationAsync: AsyncError(failure.message)),
      (response) async {
        /// When success login, save session user
        await read(appConfigActionNotifier.notifier).setSessionUser(response.user);
        return state = state.copyWith(authenticationAsync: AsyncData(response));
      },
    );
  }
}
