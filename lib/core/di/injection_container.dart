// lib/core/di/injection_container.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Core Network Infrastructure
import 'package:printer_client/core/network/dio_client.dart';
import 'package:printer_client/core/network/auth_interceptor.dart';
import 'package:printer_client/core/network/auth_event_bus.dart';

// Features: Auth
import 'package:printer_client/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:printer_client/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:printer_client/features/auth/domain/repositories/auth_repository.dart';
import 'package:printer_client/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:printer_client/features/auth/presentation/bloc/auth_bloc.dart';

import '../../features/printer/data/repositories/printer_repository_impl.dart';
import '../../features/printer/domain/repositories/printer_repository.dart';
import '../../features/printer/presentation/bloc/printer_bloc.dart';

import '../../features/storage/data/repositories/filament_repository_impl.dart';
import '../../features/storage/domain/repositories/filament_repository.dart';
import '../../features/storage/presentation/bloc/filament/filament_bloc.dart';

import '../../features/storage/data/repositories/vendor_repository_impl.dart';
import '../../features/storage/domain/repositories/vendor_repository.dart';
import '../../features/storage/presentation/bloc/vendor/vendor_bloc.dart';

import '../../features/storage/data/repositories/filament_tab_repository_impl.dart';
import '../../features/storage/domain/repositories/filament_tab_repository.dart';
import '../../features/storage/presentation/bloc/filament_tab/filament_tab_bloc.dart';

import '../../features/storage/data/repositories/location_repository_impl.dart';
import '../../features/storage/domain/repositories/location_repository.dart';
import '../../features/storage/presentation/bloc/location/location_bloc.dart';

// Всередині функції init():

final sl = GetIt.instance;

/// Єдина точка збору всієї архітектури клієнта Filamentary.
Future<void> initDependencies() async {
  // ==========================================================================
  // 1. EXTERNAL SERVICES (Низькорівневі системні сервіси)
  // ==========================================================================
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => Dio());

  // ==========================================================================
  // 2. CORE NETWORK INFRASTRUCTURE (Ядро реактивної мережі)
  // ==========================================================================
  // Реєструємо єдину шину подій для відловлювання 401 помилок
  sl.registerLazySingleton(() => AuthEventBus());

  // Реєструємо інтерцептор, передаючи локальне сховище та шину подій
  sl.registerLazySingleton(() => AuthInterceptor(sl(), sl()));

  // Ініціалізуємо та конфігуруємо DioClient
  sl.registerLazySingleton<DioClient>(() {
    final dioClient = DioClient(sl<Dio>());
    // Впорскуємо AuthInterceptor у конвеєр обробки запитів Dio
    dioClient.instance.interceptors.add(sl<AuthInterceptor>());
    return dioClient;
  });

  // ==========================================================================
  // 3. DATA SOURCES (Шари безпосереднього доступу до дисків/мережі)
  // ==========================================================================
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  // ==========================================================================
  // 4. REPOSITORIES (Реалізація доменних контрактів)
  // ==========================================================================
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton<PrinterRepository>(
    () => PrinterRepositoryImpl(sl(), sl())
  );

  sl.registerLazySingleton<FilamentRepository>(
    () => FilamentRepositoryImpl(sl())
  );

  sl.registerLazySingleton<VendorRepository>(
    () => VendorRepositoryImpl(sl())
  );

  sl.registerLazySingleton<FilamentTabRepository>(
    () => FilamentTabRepositoryImpl(sl())
  );

  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(sl())
  );

  // ==========================================================================
  // 5. USE CASES (Чисті сценарії бізнес-логіки)
  // ==========================================================================
  sl.registerLazySingleton(() => SignInUseCase(sl()));

  // ==========================================================================
  // 6. BLOCs / PRESENTATION (Керування станом інтерфейсу)
  // ==========================================================================
  // Використовуємо factory: кожен екран логіну отримує свій свіжий, 
  // очищений від попередніх помилок екземпляр BLoC із захистом від витоків.
  sl.registerFactory(() => AuthBloc(
        signInUseCase: sl(),
        localDataSource: sl(),
        eventBus: sl(),
      ));
  
  sl.registerFactory(() => PrinterBloc(sl()));

  sl.registerFactory(() => FilamentBloc(sl()));

  sl.registerFactory(() => VendorBloc(sl()));

  sl.registerFactory(() => FilamentTabBloc(sl()));

  sl.registerFactory(() => LocationBloc(sl()));
}