import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/data/datasource/remote/dues_recent_activity_remote_datasource.dart';
import 'src/data/datasource/remote/dues_statistic_remote_datasource.dart';
import 'src/data/datasource/remote/user_remote_datasource.dart';
import 'src/data/repository/dues_recent_activity_repository_impl.dart';
import 'src/data/repository/dues_statistics_repository_impl.dart';
import 'src/data/repository/user_repository_impl.dart';
import 'src/presentasion/riverpod/dues_recent_activity/dues_recent_activity_notifier.dart';
import 'src/presentasion/riverpod/dues_statistics/dues_statistics_notifier.dart';
import 'src/presentasion/riverpod/user/user_notifier.dart';
import 'src/utils/constant.dart';

///* [User]

final userNotifier = StateNotifierProvider<UserNotifier, UserState>(
  (ref) => UserNotifier(
    userRepository: ref.watch(userRepository),
  ),
);

final userRepository = Provider(
  (ref) => UserRepositoryImpl(
    remoteDataSource: ref.watch(userRemoteDataSource),
  ),
);

final userRemoteDataSource = Provider(
  (ref) => UserRemoteDataSourceImpl(
    dioClient: ref.watch(_dio),
  ),
);

///* [Dues Statistics]

final duesStatisticsNotifier = StateNotifierProvider((ref) {
  return DuesStatisticsNotifier(repository: ref.watch(duesStatisticsRepository));
});

final duesStatisticsRepository = Provider((ref) {
  return DuesStatisticsRepositoryImpl(
      remoteDataSourceImpl: ref.watch(duesStatisticsRemoteDataSource));
});

final duesStatisticsRemoteDataSource = Provider((ref) {
  return DuesStatisticsRemoteDataSourceImpl(dioClient: ref.watch(_dio));
});

///* [Dues Recent Activity]

final duesRecentActivityNotifier =
    StateNotifierProvider<DuesRecentActivityNotifier, DuesRecentActivityState>((ref) {
  return DuesRecentActivityNotifier(repository: ref.watch(duesRecentActivityRepository));
});

final duesRecentActivityRepository = Provider((ref) {
  return DuesRecentActivityRepositoryImpl(
      remoteDatasource: ref.watch(duesRecentActivityRemoteDataSource));
});

final duesRecentActivityRemoteDataSource = Provider((ref) {
  return DuesRecentActivityRemoteDataSourceImpl(dioClient: ref.watch(_dio));
});

final _dio = Provider<Dio>(
  (ref) {
    final opt = BaseOptions(
        baseUrl: kBaseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 30000, // 30 seconds
        receiveTimeout: 30000 // 30 seconds
        );
    return Dio(opt);
  },
);
