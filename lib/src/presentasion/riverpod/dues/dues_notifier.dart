import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/dues_detail/dues_detail_model.dart';
import '../../../domain/repository/dues_repository.dart';

part 'dues_state.dart';

class DuesNotifier extends StateNotifier<DuesState> {
  DuesNotifier({
    required this.repository,
  }) : super(const DuesState());

  final DuesRepository repository;

  Future<DuesState> saveDues(
    String duesDetailId, {
    required int duesCategoryId,
    required int usersId,
    required int month,
    required int year,
    required int amount,
    required StatusPaid status,
    required bool paidBySomeoneElse,
    required int createdBy,
    String? description,
  }) async {
    final result = await repository.saveDues(
      duesDetailId,
      duesCategoryId: duesCategoryId,
      usersId: usersId,
      month: month,
      year: year,
      amount: amount,
      status: status,
      paidBySomeoneElse: paidBySomeoneElse,
      createdBy: createdBy,
    );

    return result.fold(
      (failure) => state = state.init(
        isError: true,
        message: failure.message,
      ),
      (message) => state = state.init(
        isError: false,
        message: message,
      ),
    );
  }
}
