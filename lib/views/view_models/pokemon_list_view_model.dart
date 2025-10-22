import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/core/constants/api_constants.dart';
import 'package:pokedex_app/data/reporsitory/pokemon/pokemon_repository.dart';
import 'package:pokedex_app/domain/entities/pokemon_list_item.dart';
import 'package:pokedex_app/views/providers/pokemon_providers.dart';

class PokemonListState {
  final List<PokemonListItem> pokemon;
  final bool isLoading;
  final bool hasMore;
  final String? errorMessage;
  final int currentOffset;

  PokemonListState({
    this.pokemon = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.errorMessage,
    this.currentOffset = 0,
  });

  PokemonListState copyWith({
    List<PokemonListItem>? pokemon,
    bool? isLoading,
    bool? hasMore,
    String? errorMessage,
    int? currentOffset,
  }) {
    return PokemonListState(
      pokemon: pokemon ?? this.pokemon,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
      currentOffset: currentOffset ?? this.currentOffset,
    );
  }
}

class PokemonListViewModel extends StateNotifier<PokemonListState> {
  final PokemonRepository repository;

  PokemonListViewModel(this.repository) : super(PokemonListState()) {
    loadPokemon();
  }

  Future<void> loadPokemon() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await repository.getPokemonList(
      limit: ApiConstants.defaultLimit,
      offset: state.currentOffset,
    );

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
      },
      (newPokemon) {
        final updatedList = [...state.pokemon, ...newPokemon];
        state = state.copyWith(
          pokemon: updatedList,
          isLoading: false,
          currentOffset: state.currentOffset + ApiConstants.defaultLimit,
          hasMore: newPokemon.length == ApiConstants.defaultLimit,
        );
      },
    );
  }

  Future<void> refresh() async {
    state = PokemonListState();
    await loadPokemon();
  }
}

final pokemonListViewModelProvider =
    StateNotifierProvider<PokemonListViewModel, PokemonListState>((ref) {
      final repository = ref.watch(pokemonRepositoryProvider);
      return PokemonListViewModel(repository);
    });
