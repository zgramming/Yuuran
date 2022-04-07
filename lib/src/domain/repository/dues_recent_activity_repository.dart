import 'package:dartz/dartz.dart';

import '../../data/model/dues_detail/dues_detail_model.dart';
import '../../utils/utils.dart';

abstract class DuesRecentActivityRepository {
  Future<Either<Failure, List<DuesDetailModel>>> get({
    int? month,
    int? year,
    int? limit,
  });
}