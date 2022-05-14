import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/data/datasource/remote/authentication_remote_datasource.dart';
import 'src/data/datasource/remote/citizen_remote_datasource.dart';
import 'src/data/datasource/remote/dues_remote_datasource.dart';
import 'src/data/repository/authentication_repository_impl.dart';
import 'src/data/repository/citizen_repository_impl.dart';
import 'src/data/repository/dues_repository_impl.dart';
import 'src/utils/utils.dart';

///* [Authentication]

final authenticationRepository = Provider(
  (ref) => AuthenticationRepositoryImpl(
    remoteDataSource: ref.watch(authenticationRemoteDataSource),
  ),
);

final authenticationRemoteDataSource = Provider(
  (ref) => AuthenticationRemoteDataSourceImpl(
    dioClient: ref.watch(_dio),
  ),
);

///* [Citizen]

final citizenRepository = Provider((ref) {
  return CitizenRepositoryImpl(remoteDataSource: ref.watch(citizenRemoteDataSource));
});

final citizenRemoteDataSource = Provider(
  (ref) => CitizenRemoteDataSourceImpl(
    dioClient: ref.watch(_dio),
  ),
);

final duesRepository = Provider(
  (ref) => DuesRepositoryImpl(
    remoteDataSource: ref.watch(_duesRemoteDataSource),
  ),
);

final _duesRemoteDataSource = Provider(
  (ref) => DuesRemoteDataSourceImpl(
    dioClient: ref.watch(_dio),
  ),
);

final _dio = Provider<Dio>((ref) {
  final opt = BaseOptions(
    baseUrl: kBaseUrl,
    receiveDataWhenStatusError: true,
    connectTimeout: 10000, // 10 seconds
    receiveTimeout: 10000, // 10 seconds
  );
  return Dio(opt);
});
