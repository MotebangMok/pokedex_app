import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:pokedex_app/data/data_source/local_data_source/local_data_source.dart';
import 'package:pokedex_app/data/data_source/pokemon_remote_data_source/pokemon_remote_data_source.dart';

import 'package:pokedex_app/data/reporsitory/pokemon/pokemon_repository_impl.dart';

@GenerateMocks([PokemonRemoteDataSource, LocalDataSource])
import 'pokemon_repository_test.mocks.dart';

void main() {
  late PokemonRepositoryImpl repository;
  late MockPokemonRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockPokemonRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    repository = PokemonRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });
}
