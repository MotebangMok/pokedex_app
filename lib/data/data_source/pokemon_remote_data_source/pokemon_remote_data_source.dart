
import 'package:pokedex_app/data/models/pokemon_detail_model.dart';
import 'package:pokedex_app/data/models/pokemon_list_response.dart';
import 'package:pokedex_app/data/models/pokemon_species_model.dart';

abstract class PokemonRemoteDataSource {
  Future<PokemonListResponse> getPokemonList({
    required int limit,
    required int offset,
  });

  Future<PokemonDetailModel> getPokemonDetail(int id);

  Future<PokemonSpeciesModel> getPokemonSpecies(int id);

  Future<List<PokemonDetailModel>> searchPokemon(String query);
}
