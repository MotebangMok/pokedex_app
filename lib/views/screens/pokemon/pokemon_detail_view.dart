import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/core/constants/pokemon_size_constant.dart';
import 'package:pokedex_app/core/utils/pokemon_type_colors.dart';
import 'package:pokedex_app/views/view_models/pokemon_details_view_model.dart';
import 'package:pokedex_app/views/widgets/pokemon_detail_skeleton.dart';
import 'package:pokedex_app/views/widgets/pokemon_sliver_appbar.dart';
import 'package:pokedex_app/views/widgets/pokemon_sliver_body_widget.dart';

class PokemonDetailView extends ConsumerWidget {
  final int pokemonId;

  const PokemonDetailView({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pokemonDetailViewModelProvider(pokemonId));

    if (state.isLoading) {
      return const PokemonDetailSkeleton();
    }

    if (state.pokemon == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text(state.errorMessage ?? 'Failed to load Pokémon'),
        ),
      );
    }

    final pokemon = state.pokemon!;
    final primaryColor = PokemonTypeColors.getColor(pokemon.types.first);
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          PokemonSliverAppBar(
            primaryColor: primaryColor,
            pokemon: pokemon,
            backgroundColor: backgroundColor,
            state: state,
            pokemonId: pokemonId,
          ),
          PokemonSliverBodyWidget(
            pokemon: pokemon,
            state: state,
            primaryColor: primaryColor,
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              bottom:
                  MediaQuery.of(context).size.height *
                  PokemonSizeConstants.bottomPaddingRatio,
            ),
          ),
        ],
      ),
    );
  }
}
