import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../domain/repository/citizen_repository.dart';

part 'citizen_action_state.dart';

class CitizenActionNotifer extends StateNotifier<CitizenActionState> {
  CitizenActionNotifer({required this.repository}) : super(const CitizenActionState());
  final CitizenRepository repository;

  Future<void> save({
    required int? id,
    required String username,
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    state = state.copyWith(saveAsync: const AsyncLoading());
    final result = await repository.saveCitizen(
      id: id,
      username: username,
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );

    result.fold(
      (failure) => state = state.copyWith(saveAsync: AsyncError(failure.message)),
      (message) => state = state.copyWith(saveAsync: AsyncData(message)),
    );
  }
}

final citizenActionNotifier = StateNotifierProvider<CitizenActionNotifer, CitizenActionState>(
  (ref) => CitizenActionNotifer(
    repository: ref.watch(citizenRepository),
  ),
);
