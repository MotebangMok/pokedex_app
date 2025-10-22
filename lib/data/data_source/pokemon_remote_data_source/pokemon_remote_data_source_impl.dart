
import 'package:dio/dio.dart';
import 'package:pokedex_app/core/constants/api_constants.dart';
import 'package:pokedex_app/data/data_source/pokemon_remote_data_source/pokemon_remote_data_source.dart';
import 'package:pokedex_app/data/models/pokemon_detail_model.dart';
import 'package:pokedex_app/data/models/pokemon_list_response.dart';
import 'package:pokedex_app/data/models/pokemon_species_model.dart';

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final Dio dio;

  PokemonRemoteDataSourceImpl({required this.dio});

  @override
  Future<PokemonListResponse> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.pokemonEndpoint,
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );

      return PokemonListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load pokemon list: ${e.message}');
    }
  }

  @override
  Future<PokemonDetailModel> getPokemonDetail(int id) async {
    try {
      final response = await dio.get('${ApiConstants.pokemonEndpoint}/$id');
      return PokemonDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load pokemon detail: ${e.message}');
    }
  }

  @override
  Future<PokemonSpeciesModel> getPokemonSpecies(int id) async {
    try {
      final response =
          await dio.get('${ApiConstants.pokemonSpeciesEndpoint}/$id');
      return PokemonSpeciesModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load pokemon species: ${e.message}');
    }
  }

  @override
  Future<List<PokemonDetailModel>> searchPokemon(String query) async {
    try {
      final response = await dio.get(
        ApiConstants.pokemonEndpoint,
        queryParameters: {
          'limit': 1000,
        },
      );

      final listResponse = PokemonListResponse.fromJson(response.data);

      final filteredPokemon = listResponse.results
          .where((pokemon) =>
              pokemon.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      final List<PokemonDetailModel> pokemonDetails = [];
      for (var pokemon in filteredPokemon.take(20)) {
        final detail = await getPokemonDetail(pokemon.toEntity().getId);
        pokemonDetails.add(detail);
      }

      return pokemonDetails;
    } on DioException catch (e) {
      throw Exception('Failed to search pokemon: ${e.message}');
    }
  }
}