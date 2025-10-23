import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/core/constants/pokemon_size_constant.dart';
import 'package:pokedex_app/views/screens/pokemon/pokemon_detail_view.dart';
import 'package:pokedex_app/views/view_models/search_view_model.dart';
import 'package:pokedex_app/views/widgets/pokemon_card_widget.dart';
import 'package:pokedex_app/views/widgets/pokemon_list_skeleton.dart';

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({
    super.key,
    required this.context,
    required this.ref,
    required this.searchState,
  });

  final BuildContext context;
  final WidgetRef ref;
  final SearchState searchState;

  @override
  Widget build(BuildContext context) {
    if (searchState.isSearching) {
      return const PokemonListSkeletonGrid();
    }

    if (searchState.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: PokemonSizeConstants.contentPadding),
            Text(
              'Search Failed',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: PokemonSizeConstants.smallSpacing),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: PokemonSizeConstants.extraLargeSpacing,
              ),
              child: Text(
                searchState.errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ref
                    .read(searchViewModelProvider.notifier)
                    .searchPokemon(searchState.query);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry Search'),
            ),
          ],
        ),
      );
    }

    if (searchState.searchResults.isEmpty && searchState.query.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: PokemonSizeConstants.contentPadding),
            Text(
              'No Pokémon Found',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: PokemonSizeConstants.mediumSpacing),
            Text(
              'Try searching for a different name',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: searchState.searchResults.length,
      itemBuilder: (context, index) {
        final pokemon = searchState.searchResults[index];
        return PokemonCardWidget(
          pokemon: pokemon,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PokemonDetailView(pokemonId: pokemon.id),
              ),
            );
          },
        );
      },
    );
  }
}
