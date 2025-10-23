import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/data/reporsitory/pokemon/pokemon_repository.dart';
import 'package:pokedex_app/di/service_locator.dart';

final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return getIt<PokemonRepository>();
});
