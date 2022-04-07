import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/dues_calendar_repository.dart';
import '../../utils/utils.dart';
import '../datasource/remote/dues_calendar_remote_datasource.dart';
import '../model/dues_detail/dues_detail_model.dart';

class DuesCalendarRepositoryImpl implements DuesCalendarRepository {
  const DuesCalendarRepositoryImpl({
    required this.remoteDataSource,
  });

  final DuesCalendarRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<DuesDetailModel>>> get({
    int? month,
    int? year,
  }) async {
    try {
      final result = await remoteDataSource.get(
        month: month,
        year: year,
      );
      return Right(result);
    } on DioError catch (error) {
      return Left(dioUtils.onError(error));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }
}
