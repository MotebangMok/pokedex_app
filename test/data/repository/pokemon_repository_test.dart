import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_app/data/data_source/local_data_source/local_data_source.dart';
import 'package:pokedex_app/data/data_source/pokemon_remote_data_source/pokemon_remote_data_source.dart';
import 'package:pokedex_app/data/models/pokemon_list_item_model.dart';
import 'package:pokedex_app/data/models/pokemon_list_response.dart';
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

  group('getPokemonList', () {
    test('should return a successful response in a list', () async {
      final mockResponse = PokemonListResponse(
        count: 9,
        results: [
          PokemonListItemModel(
            name: 'blastoise',
            url: 'https://pokeapi.co/api/v2/pokemon/9/',
          ),
          PokemonListItemModel(
            name: 'bulbasaur',
            url: 'https://pokeapi.co/api/v2/pokemon/1/',
          ),
        ],
      );

      when(
        mockRemoteDataSource.getPokemonList(
          limit: anyNamed('limit'),
          offset: anyNamed('offset'),
        ),
      ).thenAnswer((_) async => mockResponse);

      final result = await repository.getPokemonList(limit: 20, offset: 0);

      expect(result.isRight(), true);
      result.fold((failure) => fail('Should not return failure'), (
        pokemonList,
      ) {
        expect(pokemonList.length, 2);
        expect(pokemonList.first.name, 'blastoise');
        expect(pokemonList[1].name, 'bulbasaur');
      });
    });
  });
}
