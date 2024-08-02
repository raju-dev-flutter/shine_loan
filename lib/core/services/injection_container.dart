import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/app.dart';
import '../core.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  /// ********************** [Dio Config] ********************** \\\
  final dio = Dio(BaseOptions(
    baseUrl: ApiEndpoint.baseUrl,
    contentType: 'application/json; charset=utf-8',
    responseType: ResponseType.json,
  ));

  final cacheOptions = CacheOptions(
    store: HiveCacheStore(PathProviderService.path),
    policy: CachePolicy.noCache,
    maxStale: const Duration(days: 30),
    keyBuilder: (options) => options.path,
  );

  final dioService = DioService(
    dioClient: dio,
    globalCacheOptions: cacheOptions,
    interceptors: [
      DioCacheInterceptor(options: cacheOptions),
      if (kDebugMode) LoggingInterceptor(),
    ],
  );

  /// ********************** [===||===] ********************** \\\

  /// [Hive DataBase]
  // await Hive.initFlutter();

  /// ********************** [Injection START] ********************** \\\
  sl

    /// [Bloc]
    /// [Authentication][Auth]
    ..registerFactory(() => AuthenticationBloc(authenticationRepository: sl()))
    // ..registerFactory(() => AuthBloc(authRepository: sl()))

    /// [Permission]
    // ..registerFactory(
    //     () => PermissionCubit(currentPermission: Permission.unknown))

    /// [Navigation]
    // ..registerFactory(() => NavigationCubit())

    /// [Stream]
    /// [Auth]
    // ..registerLazySingleton<LoginStream>(() => LoginStream())

    /// [Repositories]
    /// [Authentication][Auth]
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepository())
    // ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))

    /// [Permission]
    // ..registerLazySingleton<PermissionRepository>(() => PermissionRepository())

    /// DB [Local] and [Provider]
    /// [Login Response]
    // ..registerLazySingleton<LoginDataBaseService>(() => LoginDataBaseService())
    // ..registerLazySingleton<LoginDataBaseProvider>(
    //     () => LoginDataBaseProvider(loginDataBaseService: sl()))

    /// [External Dependencies]
    ///[Dio]
    ..registerSingleton<ApiService>(ApiService(dioService))
    ..registerSingleton<DioService>(dioService);

  /// ********************** [Injection END] ********************** \\\

  /// ********************** Local DB [Initiating] ********************** \\\
  /// [Login Response]
  // await sl<LoginDataBaseService>().initDataBase();
}
