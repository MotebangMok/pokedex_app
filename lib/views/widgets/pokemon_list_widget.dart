import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/core/constants/pokemon_size_constant.dart';
import 'package:pokedex_app/views/view_models/pokemon_list_view_model.dart';
import 'package:pokedex_app/views/widgets/pokemon_grid_list_widget.dart';
import 'package:pokedex_app/views/widgets/pokemon_list_skeleton.dart';

class PokemonListWidget extends StatelessWidget {
  const PokemonListWidget({
    super.key,
    required this.ref,
    required this.context,
    required ScrollController scrollController,
    required this.pokemonListState,
  }) : _scrollController = scrollController;

  final WidgetRef ref;
  final BuildContext context;
  final ScrollController _scrollController;
  final PokemonListState pokemonListState;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(pokemonListViewModelProvider.notifier).refresh();
      },
      child: pokemonListState.pokemon.isEmpty && pokemonListState.isLoading
          ? const PokemonListSkeletonGrid()
          : pokemonListState.pokemon.isEmpty &&
                pokemonListState.errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade400,
                  ),
                  const SizedBox(height: PokemonSizeConstants.contentPadding),
                  Text(
                    'Failed to Load Pokémon',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: PokemonSizeConstants.extraLargeSpacing,
                    ),
                    child: Text(
                      pokemonListState.errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                  const SizedBox(height: PokemonSizeConstants.largeSpacing),
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(pokemonListViewModelProvider.notifier).refresh();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            )
          : PokemonGridListWidget(
              scrollController: _scrollController,
              pokemonListState: pokemonListState,
            ),
    );
  }
}
