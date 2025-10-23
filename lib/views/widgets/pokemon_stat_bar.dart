import 'package:flutter/material.dart';
import 'package:pokedex_app/core/constants/pokemon_size_constant.dart';

class PokemonStatBar extends StatelessWidget {
  final String statName;
  final int statValue;
  final Color color;

  const PokemonStatBar({
    super.key,
    required this.statName,
    required this.statValue,
    required this.color,
  });

  String _formatStatName() {
    return statName
        .replaceAll('-', ' ')
        .split(' ')
        .map(
          (word) =>
              word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1),
        )
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: PokemonSizeConstants.mediumSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatStatName(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                statValue.toString(),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: PokemonSizeConstants.mediumSpacing),
          LinearProgressIndicator(
            value: statValue / PokemonSizeConstants.maxStatValue,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }
}
