import 'package:flutter/material.dart';
import 'package:pokedex_app/views/widgets/shimmer_loading.dart';

class PokemonListSkeleton extends StatelessWidget {
  const PokemonListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDark
            ? Colors.grey.shade900.withValues(alpha: 0.3)
            : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ShimmerLoading(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pokemon ID Badge skeleton
              SkeletonBox(
                width: 50,
                height: 20,
                borderRadius: BorderRadius.circular(12),
              ),
              const SizedBox(height: 12),
              // Pokemon Image skeleton (circle)
              const Expanded(
                child: Center(
                  child: SkeletonBox(
                    width: 80,
                    height: 80,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Pokemon Name skeleton
              SkeletonBox(
                width: double.infinity,
                height: 16,
                borderRadius: BorderRadius.circular(8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PokemonListSkeletonGrid extends StatelessWidget {
  final int itemCount;

  const PokemonListSkeletonGrid({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => const PokemonListSkeleton(),
    );
  }
}
