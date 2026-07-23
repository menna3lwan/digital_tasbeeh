import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/tasbeeh/data/datasources/tasbeeh_local_datasource.dart';
import '../../features/tasbeeh/data/repositories/tasbeeh_repository_impl.dart';
import '../../features/tasbeeh/domain/repositories/tasbeeh_repository.dart';
import '../../features/tasbeeh/cubit/tasbeeh_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  sl
    ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)
    ..registerLazySingleton<TasbeehLocalDataSource>(
      () => TasbeehLocalDataSourceImpl(sl()),
    )
    ..registerLazySingleton<TasbeehRepository>(
      () => TasbeehRepositoryImpl(sl()),
    )
    ..registerFactory<TasbeehCubit>(
      () => TasbeehCubit(sl()),
    );
}
