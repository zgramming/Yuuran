import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/dues_detail/dues_detail_model.dart';
import '../../../domain/repository/dues_repository.dart';

part 'dues_detail_state.dart';

class DuesDetailNotifier extends StateNotifier<DuesDetailState> {
  DuesDetailNotifier({
    required this.repository,
  }) : super(const DuesDetailState());

  final DuesRepository repository;

  Future<DuesDetailState> getByID(String duesDetailID) async {
    final result = await repository.getDetailByID(duesDetailID);
    return result.fold(
      (failure) => state = state.init(
        isError: true,
        message: failure.message,
        item: null,
      ),
      (item) => state = state.init(
        item: item ?? const DuesDetailModel(),
        isError: false,
        message: "Berhasil",
      ),
    );
  }

  Future<DuesDetailState> saveDues(
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
      description: description,
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
