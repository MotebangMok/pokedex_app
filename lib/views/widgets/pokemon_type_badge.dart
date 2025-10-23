import 'package:flutter/material.dart';
import 'package:pokedex_app/core/constants/pokemon_size_constant.dart';
import 'package:pokedex_app/core/utils/pokemon_type_colors.dart';

class PokemonTypeBadge extends StatelessWidget {
  final String type;

  const PokemonTypeBadge({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final baseColor = PokemonTypeColors.getColor(type);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: PokemonSizeConstants.contentPadding,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [baseColor, baseColor.withValues(alpha: 0.7)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: baseColor.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        type.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
