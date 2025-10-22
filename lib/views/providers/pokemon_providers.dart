import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/data/reporsitory/pokemon/pokemon_repository.dart';
import 'package:pokedex_app/di/service_locator.dart';

final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return getIt<PokemonRepository>();
});

final favouriteProvider = FutureProvider<List<int>>((ref) async {
  final favRepository = ref.watch(pokemonRepositoryProvider);
  final fav = await getIt<PokemonRepository>().getFavourites();
  return fav.fold((failure) => [], (favourites) => favourites);
});

final isFavouriteProvider = FutureProvider.family<bool, int>((ref, id) async {
  final favRepository = ref.watch(pokemonRepositoryProvider);
  final fav = await favRepository.isFavourite(id);
  return fav.fold((failure) => false, (isFavourite) => isFavourite);
});
