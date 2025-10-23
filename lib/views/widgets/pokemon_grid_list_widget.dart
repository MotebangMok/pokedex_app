import 'package:flutter/material.dart';
import 'package:pokedex_app/core/constants/pokemon_size_constant.dart';
import 'package:pokedex_app/views/screens/pokemon/pokemon_detail_view.dart';
import 'package:pokedex_app/views/view_models/pokemon_list_view_model.dart';
import 'package:pokedex_app/views/widgets/pokemon_list_item_widget.dart';

class PokemonGridListWidget extends StatelessWidget {
  const PokemonGridListWidget({
    super.key,
    ScrollController? scrollController,
    required this.pokemonListState,
  }) : _scrollController = scrollController;

  final ScrollController? _scrollController;
  final PokemonListState pokemonListState;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(PokemonSizeConstants.mediumSpacing),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount:
          pokemonListState.pokemon.length + (pokemonListState.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= pokemonListState.pokemon.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(PokemonSizeConstants.contentPadding),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final pokemon = pokemonListState.pokemon[index];
        return PokemonListItemWidget(
          pokemon: pokemon,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PokemonDetailView(pokemonId: pokemon.getId),
              ),
            );
          },
        );
      },
    );
  }
}
