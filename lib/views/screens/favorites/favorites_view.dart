import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/core/constants/pokemon_size_constant.dart';
import 'package:pokedex_app/views/screens/pokemon/pokemon_detail_view.dart';
import 'package:pokedex_app/views/view_models/favorites_view_model.dart';
import 'package:pokedex_app/views/widgets/pokemon_card_widget.dart';

class FavoritesView extends ConsumerWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(favoritesViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          if (state.favoritePokemon.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.read(favoritesViewModelProvider.notifier).refresh();
              },
            ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: PokemonSizeConstants.contentPadding),
                  Text(
                    'Error loading favorites',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: PokemonSizeConstants.mediumSpacing),
                  Text(
                    state.errorMessage!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: PokemonSizeConstants.contentPadding),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(favoritesViewModelProvider.notifier).refresh();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : state.favoritePokemon.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 100,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: PokemonSizeConstants.largeSpacing),
                  Text(
                    'No Favorites Yet',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: PokemonSizeConstants.mediumSpacing),
                  Text(
                    'Start adding Pokémon to your favorites!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: PokemonSizeConstants.largeSpacing),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.explore),
                    label: const Text('Explore Pokémon'),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await ref.read(favoritesViewModelProvider.notifier).refresh();
              },
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: state.favoritePokemon.length,
                itemBuilder: (context, index) {
                  final pokemon = state.favoritePokemon[index];
                  return PokemonCardWidget(
                    pokemon: pokemon,
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              PokemonDetailView(pokemonId: pokemon.id),
                        ),
                      );

                      ref.read(favoritesViewModelProvider.notifier).refresh();
                    },
                    onRemoveFavorite: () {
                      ref
                          .read(favoritesViewModelProvider.notifier)
                          .removeFavorite(pokemon.id);
                    },
                    showRemoveButton: true,
                  );
                },
              ),
            ),
    );
  }
}
