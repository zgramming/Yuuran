import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/authentication_repository.dart';
import '../../utils/utils.dart';
import '../datasource/remote/authentication_remote_datasource.dart';
import '../model/authentication/authentication_response.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl({
    required this.remoteDataSource,
  });

  final AuthenticationRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, AuthenticationResponse>> login({
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
      return Left(dioUtils.onError(error));
    } catch (e) {
      return Left(UncaughtFailure(message: e.toString()));
    }
  }
}
