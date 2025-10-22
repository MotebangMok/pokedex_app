import 'package:dartz/dartz.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/domain/entities/pokemon.dart';
import 'package:pokedex_app/domain/entities/pokemon_list_item.dart';
abstract class PokemonRepository {
  
  Future<Either<Failure, List<PokemonListItem>>> getPokemonList({
    required int limit,
    required int offset,
  });

  Future<Either<Failure, Pokemon>> getPokemonDetail(int id);

  Future<Either<Failure, String>> getPokemonDescription(int id);

  Future<Either<Failure, List<Pokemon>>> searchPokemon(String query);

  Future<Either<Failure, void>> addFavourite(int pokemonId);

  Future<Either<Failure, void>> removeFavourite(int pokemonId);

  Future<Either<Failure, List<int>>> getFavourites();

  Future<Either<Failure, bool>> isFavourite(int pokemonId);
}
