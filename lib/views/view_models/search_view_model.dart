import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/data/reporsitory/pokemon/pokemon_repository.dart';
import 'package:pokedex_app/domain/entities/pokemon.dart' show Pokemon;
import 'package:pokedex_app/views/providers/pokemon_providers.dart';

class SearchState {
  final List<Pokemon> searchResults;
  final bool isSearching;
  final String? errorMessage;
  final String query;

  SearchState({
    this.searchResults = const [],
    this.isSearching = false,
    this.errorMessage,
    this.query = '',
  });

  SearchState copyWith({
    List<Pokemon>? searchResults,
    bool? isSearching,
    String? errorMessage,
    String? query,
  }) {
    return SearchState(
      searchResults: searchResults ?? this.searchResults,
      isSearching: isSearching ?? this.isSearching,
      errorMessage: errorMessage,
      query: query ?? this.query,
    );
  }
}

class SearchViewModel extends StateNotifier<SearchState> {
  final PokemonRepository repository;

  SearchViewModel(this.repository) : super(SearchState());

  Future<void> searchPokemon(String query) async {
    if (query.trim().isEmpty) {
      state = SearchState();
      return;
    }

    state = state.copyWith(isSearching: true, errorMessage: null, query: query);

    final result = await repository.searchPokemon(query.trim());

    result.fold(
      (failure) {
        state = state.copyWith(
          isSearching: false,
          errorMessage: failure.message,
          searchResults: [],
        );
      },
      (results) {
        state = state.copyWith(
          searchResults: results,
          isSearching: false,
          errorMessage: null,
        );
      },
    );
  }

  void clearSearch() {
    state = SearchState();
  }
}

final searchViewModelProvider =
    StateNotifierProvider<SearchViewModel, SearchState>((ref) {
      final repository = ref.watch(pokemonRepositoryProvider);
      return SearchViewModel(repository);
    });
