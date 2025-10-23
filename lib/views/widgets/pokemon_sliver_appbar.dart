import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/core/constants/pokemon_size_constant.dart';
import 'package:pokedex_app/domain/entities/pokemon.dart';
import 'package:pokedex_app/views/view_models/pokemon_details_view_model.dart';

class PokemonSliverAppBar extends ConsumerWidget {
  const PokemonSliverAppBar({
    super.key,
    required this.primaryColor,
    required this.pokemon,
    required this.backgroundColor,
    required this.state,
    required this.pokemonId,
  });

  final Color primaryColor;
  final Pokemon pokemon;
  final Color backgroundColor;
  final PokemonDetailsState state;
  final int pokemonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      expandedHeight: PokemonSizeConstants.expandedHeaderHeight,
      floating: false,
      pinned: true,
      stretch: true,
      backgroundColor: primaryColor,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Calculate collapse ratio
          final expandedHeight = PokemonSizeConstants.expandedHeaderHeight;
          final collapsedHeight =
              kToolbarHeight + MediaQuery.of(context).padding.top;
          final currentHeight = constraints.maxHeight;
          final collapseRatio =
              ((currentHeight - collapsedHeight) /
                      (expandedHeight - collapsedHeight))
                  .clamp(0.0, 1.0);

          // Image size based on collapse ratio
          final imageSize =
              PokemonSizeConstants.collapsedImageSize +
              (PokemonSizeConstants.expandedImageSize * collapseRatio);
          final titleFontSize =
              PokemonSizeConstants.collapsedTitleFontSize +
              (PokemonSizeConstants.titleFontSizeRange * collapseRatio);

          return FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(
              left: collapseRatio < PokemonSizeConstants.collapseRatioThreshold
                  ? PokemonSizeConstants.titlePaddingLeft
                  : PokemonSizeConstants.titlePaddingRight,
              bottom: PokemonSizeConstants.titlePaddingBottom,
              right: PokemonSizeConstants.titlePaddingRight,
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: 'pokemon_${pokemon.id}',
                  child: Image.network(
                    pokemon.imageUrl,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.catching_pokemon,
                        size: imageSize,
                        color: Colors.white70,
                      );
                    },
                  ),
                ),
                if (collapseRatio <
                    PokemonSizeConstants.collapseRatioThreshold) ...[
                  const SizedBox(width: PokemonSizeConstants.imageNameSpacing),
                  Flexible(
                    child: Text(
                      pokemon.name.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                        shadows: const [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 3.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
            centerTitle:
                collapseRatio >= PokemonSizeConstants.collapseRatioThreshold,
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryColor.withValues(alpha: 0.8),
                    primaryColor.withValues(alpha: 0.4),
                    backgroundColor,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: 12.0,
                    right: 6.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '#${pokemon.id.toString().padLeft(3, '0')}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: PokemonSizeConstants.pokemonIdFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (collapseRatio >=
                      PokemonSizeConstants.collapseRatioThreshold)
                    Positioned(
                      bottom: PokemonSizeConstants.nameBottomPosition,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          pokemon.name.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                PokemonSizeConstants.expandedTitleFontSize +
                                (PokemonSizeConstants.titleFontSizeRange *
                                    collapseRatio),
                            fontWeight: FontWeight.bold,
                            shadows: const [
                              Shadow(
                                offset: Offset(0, 2),
                                blurRadius: 4.0,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            state.isFavourite ? Icons.favorite : Icons.favorite_border,
            color: state.isFavourite ? Colors.red : Colors.white,
          ),
          onPressed: () {
            ref
                .read(pokemonDetailViewModelProvider(pokemonId).notifier)
                .toggleFavourite();
          },
        ),
      ],
    );
  }
}
