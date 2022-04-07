import 'package:dartz/dartz.dart';

import '../../data/model/dues_statistics/dues_statistics_model.dart';
import '../../utils/utils.dart';

abstract class DuesStatisticsRepository {
  Future<Either<Failure, DuesStatisticsModel>> get({
    int? month,
    int? year,
  });
}
