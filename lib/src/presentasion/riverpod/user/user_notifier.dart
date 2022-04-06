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

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final result = await userRepository.login(
      username: username,
      password: password,
    );

    result.fold(
      (failure) => state = state.setUser(message: failure.message, isError: true),
      (data) => state = state.setUser(user: data),
    );
  }
}
