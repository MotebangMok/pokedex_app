import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/data/reporsitory/pokemon/pokemon_repository.dart';
import 'package:pokedex_app/domain/entities/pokemon.dart';
import 'package:pokedex_app/views/providers/pokemon_providers.dart';

class PokemonDetailsState {
  final Pokemon? pokemon;
  final String? description;
  final bool isLoading;
  final bool isFavourite;
  final String? errorMessage;

  PokemonDetailsState({
    this.pokemon,
    this.description,
    this.isLoading = false,
    this.isFavourite = false,
    this.errorMessage,
  });

  PokemonDetailsState copyWith({
    Pokemon? pokemon,
    String? description,
    bool? isLoading,
    bool? isFavourite,
    String? errorMessage,
  }) {
    return PokemonDetailsState(
      pokemon: pokemon ?? this.pokemon,
      description: description ?? this.description,
      isLoading: isLoading ?? this.isLoading,
      isFavourite: isFavourite ?? this.isFavourite,
      errorMessage: errorMessage,
    );
  }
}

class PokemonDetailViewModel extends StateNotifier<PokemonDetailsState> {
  final PokemonRepository repository;
  final int pokemonId;

  PokemonDetailViewModel(this.repository, this.pokemonId)
    : super(PokemonDetailsState()) {
    loadPokemonDetail();
  }

  Future<void> loadPokemonDetail() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final detailResult = await repository.getPokemonDetail(pokemonId);
    final descriptionResult = await repository.getPokemonDescription(pokemonId);
    final isFavResult = await repository.isFavourite(pokemonId);

    detailResult.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
      },
      (pokemon) {
        state = state.copyWith(
          pokemon: pokemon,
          description: descriptionResult.fold((l) => null, (r) => r),
          isFavourite: isFavResult.fold((l) => false, (r) => r),
          isLoading: false,
        );
      },
    );
  }

  Future<void> toggleFavourite() async {
    if (state.pokemon == null) return;

    if (state.isFavourite) {
      await repository.removeFavourite(pokemonId);
      state = state.copyWith(isFavourite: false);
    } else {
      await repository.addFavourite(pokemonId);
      state = state.copyWith(isFavourite: true);
    }
  }
}

final pokemonDetailViewModelProvider =
    StateNotifierProvider.family<
      PokemonDetailViewModel,
      PokemonDetailsState,
      int
    >((ref, pokemonId) {
      final repository = ref.watch(pokemonRepositoryProvider);
      return PokemonDetailViewModel(repository, pokemonId);
    });
