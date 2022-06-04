import 'package:equatable/equatable.dart';

import 'dues_detail/dues_detail_model.dart';

class DuesFormParameter extends Equatable {
  const DuesFormParameter({
    this.duesId = "new",
    this.duesCategoryId = 0,
    this.citizenId = 0,
    this.month = 0,
    this.year = 0,
    this.amount = 0,
    this.statusPaid = StatusPaid.notPaidOff,
    this.description,
    this.createdBy = 0,
  });

  final String duesId;
  final int duesCategoryId;
  final int citizenId;
  final int month;
  final int year;
  final int amount;
  final StatusPaid statusPaid;
  final String? description;
  final int createdBy;

  @override
  List<Object?> get props {
    return [
      duesId,
      duesCategoryId,
      citizenId,
      month,
      year,
      amount,
      statusPaid,
      description,
      createdBy,
    ];
  }

  @override
  String toString() {
    return 'DuesFormParameter(duesId: $duesId, duesCategoryId: $duesCategoryId, citizenId: $citizenId, month: $month, year: $year, amount: $amount, statusPaid: $statusPaid, description: $description, createdBy: $createdBy)';
  }

  DuesFormParameter copyWith({
    String? duesId,
    int? duesCategoryId,
    int? citizenId,
    int? month,
    int? year,
    int? amount,
    StatusPaid? statusPaid,
    String? description,
    int? createdBy,
  }) {
    return DuesFormParameter(
      duesId: duesId ?? this.duesId,
      duesCategoryId: duesCategoryId ?? this.duesCategoryId,
      citizenId: citizenId ?? this.citizenId,
      month: month ?? this.month,
      year: year ?? this.year,
      amount: amount ?? this.amount,
      statusPaid: statusPaid ?? this.statusPaid,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
