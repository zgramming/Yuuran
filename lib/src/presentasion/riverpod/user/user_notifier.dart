import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/user/user_model.dart';
import '../../../domain/repository/user_repository.dart';

part 'user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier({
    required this.userRepository,
  }) : super(const UserState());

  final UserRepository userRepository;

  Future<UserState> login({
    required String username,
    required String password,
  }) async {
    final result = await userRepository.login(
      username: username,
      password: password,
    );

    return result.fold(
      (failure) => state = state.setUser(
        user: null,
        message: failure.message,
        isError: true,
      ),
      (user) => state = state.setUser(user: user),
    );
  }
}
