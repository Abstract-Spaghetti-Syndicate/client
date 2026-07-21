import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:printer_client/core/database/app_database.dart';

// Storage Feature Imports
import 'package:printer_client/features/storage/data/datasources/filament_local_data_source.dart';
import 'package:printer_client/features/storage/data/datasources/filament_remote_data_source.dart';
import 'package:printer_client/features/storage/data/repositories/filament_repository_impl.dart';
import 'package:printer_client/features/storage/domain/repositories/filament_repository.dart';
import 'package:printer_client/features/storage/domain/usecases/watch_filaments.dart';
import 'package:printer_client/features/storage/domain/usecases/add_filament.dart';
import 'package:printer_client/features/storage/presentation/bloc/filament/filament_bloc.dart';

// Printer Feature Imports
import 'package:printer_client/features/printer/presentation/bloc/printer_bloc.dart';
import 'package:printer_client/features/printer/domain/usecases/get_printer_status.dart';
import 'package:printer_client/features/printer/domain/repositories/printer_repository.dart';
import 'package:printer_client/features/printer/data/repositories/printer_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External Dependencies
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  //! Features - Printer
  sl.registerFactory(() => PrinterBloc(getPrinterStatus: sl()));
  sl.registerLazySingleton(() => GetPrinterStatus(sl()));
  sl.registerLazySingleton<PrinterRepository>(
    () => PrinterRepositoryImpl(sl(), sl()), 
  );

  //! Features - Storage (Filaments)
  sl.registerFactory(() => FilamentBloc(
        watchFilaments: sl(),
        addFilament: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => WatchFilaments(sl()));
  sl.registerLazySingleton(() => AddFilament(sl()));

  // Repository
  sl.registerLazySingleton<FilamentRepository>(
    () => FilamentRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<FilamentLocalDataSource>(
    () => FilamentLocalDataSourceImpl(database: sl()),
  );
  sl.registerLazySingleton<FilamentRemoteDataSource>(
    () => FilamentRemoteDataSourceImpl(dio: sl()),
  );
}