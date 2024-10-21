import 'package:civic_watch/router.dart';
import 'package:civic_watch/services/auth_service.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'local_storage_service.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt
    ..registerSingleton<GoRouter>(router)
    ..registerSingleton<AuthService>(AuthService())
    ..registerSingleton<LocalStorageService>(LocalStorageService());
}
