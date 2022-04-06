import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/user_repository.dart';
import '../../utils/utils.dart';
import '../datasource/remote/user_remote_datasource.dart';
import '../model/user/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({
    required this.remoteDataSource,
  });

  final UserRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, UserModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(
        username: username,
        password: password,
      );
      return Right(result);
    } on DioError catch (error) {
      final data = error.response?.data;
      switch (error.type) {
        case DioErrorType.response:
          return Left(ResponseFailure(message: data['message']));
        case DioErrorType.connectTimeout:
          return const Left(ConnectionTimeoutFailure());
        case DioErrorType.receiveTimeout:
          return const Left(ReceiveTimeoutFailure());
        case DioErrorType.sendTimeout:
          return const Left(SendTimeoutFailure());
        default:
          return const Left(UncaughtFailure());
      }
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }
}
