import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/data/data_source/local_data_source/local_data_source.dart';
import 'package:pokedex_app/data/data_source/pokemon_remote_data_source/pokemon_remote_data_source.dart';
import 'package:pokedex_app/data/models/pokemon_detail_model.dart';
import 'package:pokedex_app/data/models/pokemon_list_item_model.dart';
import 'package:pokedex_app/data/models/pokemon_list_response.dart';
import 'package:pokedex_app/data/models/pokemon_species_model.dart';
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

    test('should return ServerFailure when call throws exception', () async {
      when(
        mockRemoteDataSource.getPokemonList(
          limit: anyNamed('limit'),
          offset: anyNamed('offset'),
        ),
      ).thenThrow(Exception('Failed to load'));

      final result = await repository.getPokemonList(limit: 20, offset: 0);

      expect(result.isLeft(), true);
    });

    test(
      'should return NetworkFailure when request times out',
      () async {
        final completer = Completer<PokemonListResponse>();

        when(
          mockRemoteDataSource.getPokemonList(
            limit: anyNamed('limit'),
            offset: anyNamed('offset'),
          ),
        ).thenAnswer((_) => completer.future);

        final result = await repository.getPokemonList(limit: 20, offset: 0);

        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.message, contains('timeout'));
        }, (_) => fail('Should return NetworkFailure'));
      },
      timeout: const Timeout(Duration(seconds: 15)),
    );
  });

  group('getPokemonDetail', () {
    test('should return pokemon detail when call is successful', () async {
      final mockDetail = PokemonDetailModel(
        id: 1,
        name: 'bulbasaur',
        height: 7,
        weight: 69,
        types: [
          PokemonTypeModel(
            slot: 1,
            type: TypeInfoModel(
              name: 'grass',
              url: 'https://pokeapi.co/api/v2/type/12/',
            ),
          ),
          PokemonTypeModel(
            slot: 2,
            type: TypeInfoModel(
              name: 'poison',
              url: 'https://pokeapi.co/api/v2/type/4/',
            ),
          ),
        ],
        stats: [
          PokemonStatModel(
            baseStat: 45,
            effort: 0,
            stat: StatInfoModel(
              name: 'hp',
              url: 'https://pokeapi.co/api/v2/stat/1/',
            ),
          ),
        ],
        sprites: PokemonSpritesModel(
          frontDefault:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
          other: OtherSpritesModel(
            officialArtwork: OfficialArtworkModel(
              frontDefault:
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
            ),
          ),
        ),
      );

      when(
        mockRemoteDataSource.getPokemonDetail(any),
      ).thenAnswer((_) async => mockDetail);

      final result = await repository.getPokemonDetail(1);

      expect(result.isRight(), true);
      result.fold((failure) => fail('Should not return failure'), (pokemon) {
        expect(pokemon.id, 1);
        expect(pokemon.name, 'bulbasaur');
        expect(pokemon.types.length, 2);
        expect(pokemon.types, ['grass', 'poison']);
        expect(pokemon.height, 7);
        expect(pokemon.weight, 69);
      });
    });

    test('should return ServerFailure when call throws exception', () async {
      when(
        mockRemoteDataSource.getPokemonDetail(any),
      ).thenThrow(Exception('Failed to load'));

      final result = await repository.getPokemonDetail(1);

      expect(result.isLeft(), true);
    });

    test(
      'should return NetworkFailure when detail request times out',
      () async {
        final completer = Completer<PokemonDetailModel>();

        when(
          mockRemoteDataSource.getPokemonDetail(any),
        ).thenAnswer((_) => completer.future);

        final result = await repository.getPokemonDetail(1);

        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.message, contains('timeout'));
        }, (_) => fail('Should return NetworkFailure'));
      },
      timeout: const Timeout(Duration(seconds: 15)),
    );
  });

  group('getPokemonDescription', () {
    test('should return english description when call is successful', () async {
      final mockSpecies = PokemonSpeciesModel(
        flavorTextEntries: [
          FlavorTextModel(
            flavorText:
                'A strange seed was\nplanted on its\nback at birth.\fThe plant sprouts\nand grows with\nthis POKéMON.',
            language: LanguageModel(
              name: 'en',
              url: 'https://pokeapi.co/api/v2/language/9/',
            ),
          ),
          FlavorTextModel(
            flavorText: 'うまれたときから せなかに ふしぎな タネが うえてあって からだと ともに そだつという。',
            language: LanguageModel(
              name: 'ja',
              url: 'https://pokeapi.co/api/v2/language/1/',
            ),
          ),
        ],
      );

      when(
        mockRemoteDataSource.getPokemonSpecies(any),
      ).thenAnswer((_) async => mockSpecies);

      final result = await repository.getPokemonDescription(1);

      expect(result.isRight(), true);
      result.fold((failure) => fail('Should not return failure'), (
        description,
      ) {
        expect(description, isNotEmpty);
        expect(description, contains('strange seed'));
        expect(description, contains('plant sprouts'));
        expect(description.contains('\n'), false);
        expect(description.contains('\f'), false);
      });
    });

    test(
      'should return default message when no english description exists',
      () async {
        final mockSpecies = PokemonSpeciesModel(
          flavorTextEntries: [
            FlavorTextModel(
              flavorText: 'うまれたときから せなか�� ふしぎな タネが うえてあって からだと ともに そだつという。',
              language: LanguageModel(
                name: 'ja',
                url: 'https://pokeapi.co/api/v2/language/1/',
              ),
            ),
          ],
        );

        when(
          mockRemoteDataSource.getPokemonSpecies(any),
        ).thenAnswer((_) async => mockSpecies);

        final result = await repository.getPokemonDescription(1);

        expect(result.isRight(), true);
        result.fold((failure) => fail('Should not return failure'), (
          description,
        ) {
          expect(description, 'No description available.');
        });
      },
    );

    test('should return ServerFailure when call throws exception', () async {
      when(
        mockRemoteDataSource.getPokemonSpecies(any),
      ).thenThrow(Exception('Failed to load species'));

      final result = await repository.getPokemonDescription(1);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Should return ServerFailure'),
      );
    });

    test(
      'should return NetworkFailure when species request times out',
      () async {
        final completer = Completer<PokemonSpeciesModel>();

        when(
          mockRemoteDataSource.getPokemonSpecies(any),
        ).thenAnswer((_) => completer.future);

        final result = await repository.getPokemonDescription(1);

        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.message, contains('timeout'));
        }, (_) => fail('Should return NetworkFailure'));
      },
      timeout: const Timeout(Duration(seconds: 15)),
    );
  });

  group('favourites', () {
    test('should add pokemon to favourites', () async {
      when(
        mockLocalDataSource.addFavourite(any),
      ).thenAnswer((_) async => Future.value());

      final result = await repository.addFavourite(1);

      expect(result.isRight(), true);
      verify(mockLocalDataSource.addFavourite(1)).called(1);
    });

    test('should remove pokemon from favourites', () async {
      when(
        mockLocalDataSource.removeFavourite(any),
      ).thenAnswer((_) async => Future.value());

      final result = await repository.removeFavourite(1);

      expect(result.isRight(), true);
      verify(mockLocalDataSource.removeFavourite(1)).called(1);
    });

    test('should return list of favourite pokemon ids', () async {
      when(
        mockLocalDataSource.getFavourites(),
      ).thenAnswer((_) async => [1, 2, 3]);

      final result = await repository.getFavourites();

      expect(result.isRight(), true);
      result.fold((failure) => fail('Should not return failure'), (favourites) {
        expect(favourites.length, 3);
        expect(favourites, [1, 2, 3]);
      });
    });
  });
}
