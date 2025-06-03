import 'package:dio/dio.dart';
import 'package:flutter_alice/alice.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../flavor/flavour_config.dart';
import '../network/network_interceptor.dart';
import '../shared_preferences/shared_preference_service.dart';

final getIt = GetIt.instance;

/// TODO Declare all your initialization here
Future<void> initDepInject() async {
  // Singleton initialization
  final sharedPreference = await SharedPreferences.getInstance();
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

  // UseCase initialization

  // Bloc initialization

  // etc...
}
