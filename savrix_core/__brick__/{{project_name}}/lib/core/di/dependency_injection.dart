import 'package:{{project_name.snakeCase()}}/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:{{project_name.snakeCase()}}/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:{{project_name.snakeCase()}}/features/pokemon/domain/usecase/pokemon_usecase.dart';
import 'package:{{project_name.snakeCase()}}/features/pokemon/presentation/bloc/pokemon_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_alice/alice.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'package:{{project_name.snakeCase()}}/features/counter/presentation/bloc/counter_bloc.dart';
import 'package:{{project_name.snakeCase()}}/core/flavor/flavour_config.dart';
import 'package:{{project_name.snakeCase()}}/core/network/network_interceptor.dart';
import 'package:{{project_name.snakeCase()}}/core/shared_preferences/shared_preference_service.dart';
import 'package:{{project_name.snakeCase()}}/main.dart';

final getIt = GetIt.instance;

/// TODO Declare all your initialization here
Future<void> initDepInject() async {
  // Singleton initialization
  final sharedPreference = FlutterSecureStorage();
  getIt.registerSingleton<SharedPreferenceService>(
    SharedPreferenceService(sharedPreference),
  );

  getIt.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: FlavorConfig.instance.values.baseUrl,
      ),
    ),
  );

  getIt.registerLazySingleton<Alice>(
    () => Alice(
      navigatorKey: navigatorKey,
    ),
  );

  addInterceptors(
    dio: getIt(),
    sharedPreferences: getIt<SharedPreferenceService>(),
  );

  // Repository initialization
  getIt.registerLazySingleton<PokemonRepository>(
        () => PokemonRepositoryImpl(
      dio: getIt(),
    ),
  );

  // UseCase initialization
  getIt.registerLazySingleton(() => PokemonUseCase(pokemonRepository: getIt()));

  // Bloc initialization
  getIt.registerFactory(() => CounterBloc());
  getIt.registerFactory(() => PokemonBloc(pokemonUseCase: getIt()));

  // etc...
}
