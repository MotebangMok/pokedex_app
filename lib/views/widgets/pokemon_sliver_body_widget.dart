import 'package:flutter/material.dart';
import 'package:pokedex_app/core/constants/pokemon_size_constant.dart';
import 'package:pokedex_app/domain/entities/pokemon.dart';
import 'package:pokedex_app/views/view_models/pokemon_details_view_model.dart';
import 'package:pokedex_app/views/widgets/pokemon_attribute_card.dart';
import 'package:pokedex_app/views/widgets/pokemon_stat_bar.dart';
import 'package:pokedex_app/views/widgets/pokemon_type_badge.dart';

class PokemonSliverBodyWidget extends StatelessWidget {
  const PokemonSliverBodyWidget({
    super.key,
    required this.pokemon,
    required this.state,
    required this.primaryColor,
  });

  final Pokemon pokemon;
  final PokemonDetailsState state;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(PokemonSizeConstants.contentPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Types',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: PokemonSizeConstants.smallSpacing),
            Wrap(
              spacing: 8,
              children: pokemon.types
                  .map((type) => PokemonTypeBadge(type: type))
                  .toList(),
            ),
            const SizedBox(height: PokemonSizeConstants.sectionSpacing),
            if (state.description != null) ...[
              Text(
                'Description',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: PokemonSizeConstants.smallSpacing),
              Text(
                state.description!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: PokemonSizeConstants.sectionSpacing),
            ],
            Text(
              'Physical Attributes',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: PokemonSizeConstants.smallSpacing),
            Row(
              children: [
                Expanded(
                  child: PokemonAttributeCard(
                    icon: Icons.height,
                    value: '${pokemon.height / 10} m',
                    label: 'Height',
                  ),
                ),
                Expanded(
                  child: PokemonAttributeCard(
                    icon: Icons.monitor_weight,
                    value: '${pokemon.weight / 10} kg',
                    label: 'Weight',
                  ),
                ),
              ],
            ),
            const SizedBox(height: PokemonSizeConstants.sectionSpacing),
            Text(
              'Base Stats',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: PokemonSizeConstants.smallSpacing),
            ...pokemon.stats.entries.map((stat) {
              return PokemonStatBar(
                statName: stat.key,
                statValue: stat.value,
                color: primaryColor,
              );
            }),
            const SizedBox(height: PokemonSizeConstants.sectionSpacing),
          ],
        ),
      ),
    );
  }
}
