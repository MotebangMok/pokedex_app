import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/views/providers/search_state_provider.dart';
import 'package:pokedex_app/views/providers/theme_provider.dart';
import 'package:pokedex_app/views/screens/auth/login_view.dart';
import 'package:pokedex_app/views/screens/favorites/favorites_view.dart';
import 'package:pokedex_app/views/view_models/auth_view_model.dart';
import 'package:pokedex_app/views/view_models/pokemon_list_view_model.dart';
import 'package:pokedex_app/views/view_models/search_view_model.dart';
import 'package:pokedex_app/views/widgets/pokemon_list_widget.dart';
import 'package:pokedex_app/views/widgets/search_results_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchChanged);
  }

  void _onScroll() {
    final isSearchMode = ref.read(searchStateProvider);
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!isSearchMode) {
        ref.read(pokemonListViewModelProvider.notifier).loadPokemon();
      }
    }
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = _searchController.text.trim();
      if (query.isEmpty) {
        // Update search mode using Riverpod provider
        ref.read(searchStateProvider.notifier).state = false;
        ref.read(searchViewModelProvider.notifier).clearSearch();
      } else {
        // Update search mode using Riverpod provider
        ref.read(searchStateProvider.notifier).state = true;
        ref.read(searchViewModelProvider.notifier).searchPokemon(query);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonListState = ref.watch(pokemonListViewModelProvider);
    final searchState = ref.watch(searchViewModelProvider);
    final themeMode = ref.watch(themeProvider);
    final isSearchMode = ref.watch(searchStateProvider);

    return Scaffold(
      appBar: _homeViewAppBar(context, themeMode),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Pokémon by name...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
            ),
          ),
          Expanded(
            child: isSearchMode
                ? SearchResultsWidget(
                    context: context,
                    ref: ref,
                    searchState: searchState,
                  )
                : PokemonListWidget(
                    ref: ref,
                    context: context,
                    scrollController: _scrollController,
                    pokemonListState: pokemonListState,
                  ),
          ),
        ],
      ),
    );
  }

  AppBar _homeViewAppBar(BuildContext context, ThemeMode themeMode) {
    return AppBar(
      title: const Text('Pokédex'),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite),
          tooltip: 'Favorites',
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const FavoritesView()));
          },
        ),
        IconButton(
          icon: Icon(
            themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
          ),
          onPressed: () {
            ref.read(themeProvider.notifier).toggleTheme();
          },
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            final navigator = Navigator.of(context);
            await ref.read(authViewModelProvider.notifier).signOut();
            if (!mounted) return;
            navigator.pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginView()),
            );
          },
        ),
      ],
    );
  }
}
