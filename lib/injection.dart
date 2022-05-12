import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/data/datasource/remote/authentication_remote_datasource.dart';
import 'src/data/datasource/remote/citizen_remote_datasource.dart';
import 'src/data/datasource/remote/dues_remote_datasource.dart';
import 'src/data/repository/authentication_repository_impl.dart';
import 'src/data/repository/citizen_repository_impl.dart';
import 'src/data/repository/dues_repository_impl.dart';
import 'src/presentasion/riverpod/app_config/app_config_notifier.dart';
import 'src/presentasion/riverpod/dues_calendar/dues_calendar_notifier.dart';
import 'src/presentasion/riverpod/dues_category/dues_category_notifier.dart';
import 'src/presentasion/riverpod/dues_citizen/dues_citizen_notifier.dart';
import 'src/presentasion/riverpod/dues_detail/dues_detail_notifier.dart';
import 'src/presentasion/riverpod/dues_recent_activity/dues_recent_activity_notifier.dart';
import 'src/presentasion/riverpod/dues_statistics/dues_statistics_notifier.dart';
import 'src/presentasion/riverpod/user/authentication_notifier.dart';
import 'src/utils/constant.dart';

///* [App Config]

final appConfigNotifer =
    StateNotifierProvider<AppConfigNotifier, AppConfigState>((ref) => AppConfigNotifier());

///* [User]

final authenticationNotifier = StateNotifierProvider<AuthenticationNotifier, AuthenticationState>(
  (ref) => AuthenticationNotifier(
    repository: ref.watch(userRepository),
    read: ref.read,
  ),
);

final userRepository = Provider(
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

///* [Dues Calendar]
final duesCalendarNotifier = StateNotifierProvider<DuesCalendarNotifier, DuesCalendarState>((ref) {
  return DuesCalendarNotifier(repository: ref.watch(_duesRepository));
});

///* [Dues Citizen]
final duesCitizenNotifier = StateNotifierProvider<DuesCitizenNotifier, DuesCitizenState>((ref) {
  return DuesCitizenNotifier(repository: ref.watch(_duesRepository));
});

///* [Dues Statistics]
final duesStatisticsNotifier =
    StateNotifierProvider<DuesStatisticsNotifier, DuesStatisticsState>((ref) {
  return DuesStatisticsNotifier(repository: ref.watch(_duesRepository));
});

///* [Dues Recent Activity]
final duesRecentActivityNotifier =
    StateNotifierProvider<DuesRecentActivityNotifier, DuesRecentActivityState>((ref) {
  return DuesRecentActivityNotifier(repository: ref.watch(_duesRepository));
});

///* [Dues Category]
final duesCategoryNotifier = StateNotifierProvider<DuesCategoryNotifier, DuesCategoryState>(
  (ref) => DuesCategoryNotifier(
    repository: ref.watch(_duesRepository),
  ),
);

///* [Dues Detail Notifier]

final duesDetailNotifier = StateNotifierProvider<DuesDetailNotifier, DuesDetailState>((ref) {
  return DuesDetailNotifier(repository: ref.watch(_duesRepository));
});

final _duesRepository = Provider(
  (ref) => DuesRepositoryImpl(
    remoteDataSource: ref.watch(_duesRemoteDataSource),
  ),
);

final _duesRemoteDataSource = Provider(
  (ref) => DuesRemoteDataSourceImpl(
    dioClient: ref.watch(_dio),
  ),
);

final _dio = Provider<Dio>(
  (ref) {
    final opt = BaseOptions(
        baseUrl: kBaseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 10000, // 10 seconds
        receiveTimeout: 10000 // 10 seconds
        );
    return Dio(opt);
  },
);
