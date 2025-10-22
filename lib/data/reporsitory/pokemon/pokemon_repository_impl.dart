import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/data/data_source/local_data_source/local_data_source.dart';
import 'package:pokedex_app/data/data_source/pokemon_remote_data_source/pokemon_remote_data_source.dart';
import 'package:pokedex_app/data/reporsitory/pokemon/pokemon_repository.dart';
import 'package:pokedex_app/domain/entities/pokemon.dart';
import 'package:pokedex_app/domain/entities/pokemon_list_item.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  static const Duration _timeout = Duration(seconds: 30);

  PokemonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<PokemonListItem>>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final result = await remoteDataSource
          .getPokemonList(
            limit: limit,
            offset: offset,
          )
          .timeout(
            _timeout,
            onTimeout: () {
              throw TimeoutException(
                'Request timed out after ${_timeout.inSeconds} seconds',
              );
            },
          );
      final entities = result.results.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on TimeoutException catch (e) {
      return Left(NetworkFailure('Request timeout: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemonDetail(int id) async {
    try {
      final result = await remoteDataSource
          .getPokemonDetail(id)
          .timeout(
            _timeout,
            onTimeout: () {
              throw TimeoutException(
                'Request timed out after ${_timeout.inSeconds} seconds',
              );
            },
          );
      return Right(result.toEntity());
    } on TimeoutException catch (e) {
      return Left(NetworkFailure('Request timeout: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getPokemonDescription(int id) async {
    try {
      final result = await remoteDataSource
          .getPokemonSpecies(id)
          .timeout(
            _timeout,
            onTimeout: () {
              throw TimeoutException(
                'Request timed out after ${_timeout.inSeconds} seconds',
              );
            },
          );
      return Right(result.getEnglishDescription());
    } on TimeoutException catch (e) {
      return Left(NetworkFailure('Request timeout: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Pokemon>>> searchPokemon(String query) async {
    try {
      final result = await remoteDataSource
          .searchPokemon(query)
          .timeout(
            _timeout,
            onTimeout: () {
              throw TimeoutException(
                'Search request timed out after ${_timeout.inSeconds} seconds',
              );
            },
          );
      final entities = result.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on TimeoutException catch (e) {
      return Left(NetworkFailure('Request timeout: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addFavourite(int pokemonId) async {
    try {
      await localDataSource.addFavourite(pokemonId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavourite(int pokemonId) async {
    try {
      await localDataSource.removeFavourite(pokemonId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getFavourites() async {
    try {
      final result = await localDataSource.getFavourites();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavourite(int pokemonId) async {
    try {
      final result = await localDataSource.isFavourite(pokemonId);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
