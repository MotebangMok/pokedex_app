
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_app/core/network/dio_client.dart';
import 'package:pokedex_app/data/data_source/local_data_source/local_data_source.dart';
import 'package:pokedex_app/data/data_source/local_data_source/local_data_source_impl.dart';
import 'package:pokedex_app/data/data_source/pokemon_remote_data_source/pokemon_remote_data_source.dart';
import 'package:pokedex_app/data/data_source/pokemon_remote_data_source/pokemon_remote_data_source_impl.dart';
import 'package:pokedex_app/data/reporsitory/auth/auth_repository.dart';
import 'package:pokedex_app/data/reporsitory/auth/auth_repository_impl.dart';
import 'package:pokedex_app/data/reporsitory/pokemon/pokemon_repository.dart';
import 'package:pokedex_app/data/reporsitory/pokemon/pokemon_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  getIt.registerLazySingleton<DioClient>(() => DioClient());

  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<PokemonRemoteDataSource>(
    () => PokemonRemoteDataSourceImpl(dio: getIt<DioClient>().dio),
  );

  getIt.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(
      remoteDataSource: getIt<PokemonRemoteDataSource>(),
      localDataSource: getIt<LocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(firebaseAuth: getIt<FirebaseAuth>()),
  );
}
