import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/dues_statistics_repository.dart';
import '../../utils/utils.dart';
import '../datasource/remote/dues_statistic_remote_datasource.dart';
import '../model/dues_statistics/dues_statistics_model.dart';

class DuesStatisticsRepositoryImpl implements DuesStatisticsRepository {
  const DuesStatisticsRepositoryImpl({
    required this.remoteDataSourceImpl,
  });

  final DuesStatisticsRemoteDataSourceImpl remoteDataSourceImpl;
  @override
  Future<Either<Failure, DuesStatisticsModel>> get({
    int? month,
    int? year,
  }) async {
    try {
      final result = await remoteDataSourceImpl.get(month: month, year: year);
      return Right(result);
    } on DioError catch (error) {
      return Left(dioUtils.onError(error));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }
}
