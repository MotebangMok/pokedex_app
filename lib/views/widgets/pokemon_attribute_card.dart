import 'package:flutter/material.dart';
import 'package:pokedex_app/core/constants/pokemon_size_constant.dart';

class PokemonAttributeCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const PokemonAttributeCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(PokemonSizeConstants.contentPadding),
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: PokemonSizeConstants.mediumSpacing),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
