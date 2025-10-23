import 'package:flutter/material.dart';
import 'package:pokedex_app/core/constants/pokemon_size_constant.dart';
import 'package:pokedex_app/views/widgets/shimmer_loading.dart';

class PokemonDetailSkeleton extends StatelessWidget {
  const PokemonDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Skeleton AppBar
          SliverAppBar(
            expandedHeight: PokemonSizeConstants.expandedHeaderHeight,
            floating: false,
            pinned: true,
            backgroundColor: isDark
                ? Colors.grey.shade800
                : Colors.grey.shade300,
            flexibleSpace: FlexibleSpaceBar(
              background: ShimmerLoading(
                child: Container(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                  child: const Center(
                    child: SkeletonBox(
                      width: 150,
                      height: 150,
                      borderRadius: BorderRadius.all(Radius.circular(75)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Skeleton Content
          SliverToBoxAdapter(
            child: ShimmerLoading(
              child: Padding(
                padding: const EdgeInsets.all(
                  PokemonSizeConstants.contentPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Types section
                    const SkeletonBox(width: 60, height: 24),
                    const SizedBox(height: PokemonSizeConstants.smallSpacing),
                    Row(
                      children: [
                        SkeletonBox(
                          width: 80,
                          height: PokemonSizeConstants.extraLargeSpacing,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        const SizedBox(width: 8),
                        SkeletonBox(
                          width: 80,
                          height: PokemonSizeConstants.extraLargeSpacing,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ],
                    ),
                    const SizedBox(height: PokemonSizeConstants.sectionSpacing),

                    // Description section
                    const SkeletonBox(width: 100, height: 24),
                    const SizedBox(height: PokemonSizeConstants.smallSpacing),
                    const SkeletonBox(
                      width: double.infinity,
                      height: PokemonSizeConstants.contentPadding,
                    ),
                    const SizedBox(height: 8),
                    const SkeletonBox(
                      width: double.infinity,
                      height: PokemonSizeConstants.contentPadding,
                    ),
                    const SizedBox(height: 8),
                    const SkeletonBox(
                      width: 200,
                      height: PokemonSizeConstants.contentPadding,
                    ),
                    const SizedBox(height: PokemonSizeConstants.sectionSpacing),

                    // Physical Attributes section
                    const SkeletonBox(
                      width: 150,
                      height: PokemonSizeConstants.largeSpacing,
                    ),
                    const SizedBox(height: PokemonSizeConstants.smallSpacing),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(
                              PokemonSizeConstants.contentPadding,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.grey.shade900.withValues(alpha: 0.3)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Column(
                              children: [
                                SkeletonBox(width: 30, height: 30),
                                SizedBox(height: 8),
                                SkeletonBox(width: 60, height: 20),
                                SizedBox(height: 4),
                                SkeletonBox(width: 40, height: 14),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(
                              PokemonSizeConstants.contentPadding,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.grey.shade900.withValues(alpha: 0.3)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Column(
                              children: [
                                SkeletonBox(width: 30, height: 30),
                                SizedBox(height: 8),
                                SkeletonBox(width: 60, height: 20),
                                SizedBox(height: 4),
                                SkeletonBox(width: 40, height: 14),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: PokemonSizeConstants.sectionSpacing),

                    // Base Stats section
                    const SkeletonBox(width: 100, height: 24),
                    const SizedBox(height: PokemonSizeConstants.smallSpacing),
                    ...List.generate(
                      6,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: PokemonSizeConstants.mediumSpacing,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SkeletonBox(
                                  width: 80,
                                  height: 16,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                SkeletonBox(
                                  width: 30,
                                  height: 16,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: PokemonSizeConstants.mediumSpacing,
                            ),
                            SkeletonBox(
                              width: double.infinity,
                              height: 4,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
