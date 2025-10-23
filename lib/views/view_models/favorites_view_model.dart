import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/data/reporsitory/pokemon/pokemon_repository.dart';
import 'package:pokedex_app/domain/entities/pokemon.dart';
import 'package:pokedex_app/views/providers/pokemon_providers.dart';

class FavoritesState {
  final List<Pokemon> favoritePokemon;
  final bool isLoading;
  final String? errorMessage;

  FavoritesState({
    this.favoritePokemon = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  FavoritesState copyWith({
    List<Pokemon>? favoritePokemon,
    bool? isLoading,
    String? errorMessage,
  }) {
    return FavoritesState(
      favoritePokemon: favoritePokemon ?? this.favoritePokemon,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class FavoritesViewModel extends StateNotifier<FavoritesState> {
  final PokemonRepository repository;

  FavoritesViewModel(this.repository) : super(FavoritesState()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final favouritesResult = await repository.getFavourites();

    await favouritesResult.fold(
      (failure) async {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
      },
      (favouriteIds) async {
        if (favouriteIds.isEmpty) {
          state = state.copyWith(favoritePokemon: [], isLoading: false);
          return;
        }

        final List<Pokemon> pokemonList = [];

        for (final id in favouriteIds) {
          final result = await repository.getPokemonDetail(id);
          result.fold(
            (failure) {
              // Skip failed Pokemon
            },
            (pokemon) {
              pokemonList.add(pokemon);
            },
          );
        }

        state = state.copyWith(favoritePokemon: pokemonList, isLoading: false);
      },
    );
  }

  Future<void> removeFavorite(int pokemonId) async {
    await repository.removeFavourite(pokemonId);
    await loadFavorites();
  }

  Future<void> refresh() async {
    await loadFavorites();
  }
}

final favoritesViewModelProvider =
    StateNotifierProvider<FavoritesViewModel, FavoritesState>((ref) {
      final repository = ref.watch(pokemonRepositoryProvider);
      return FavoritesViewModel(repository);
    });
