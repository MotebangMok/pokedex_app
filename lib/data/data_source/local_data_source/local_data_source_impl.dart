
import 'dart:convert';

import 'package:pokedex_app/data/data_source/local_data_source/local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String favouritesKey = 'favourites';
  static const String themeModeKey = 'theme_mode';

  LocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> saveFavourites(List<int> pokemonIds) async {
    final jsonString = json.encode(pokemonIds);
    await sharedPreferences.setString(favouritesKey, jsonString);
  }

  @override
  Future<List<int>> getFavourites() async {
    final jsonString = sharedPreferences.getString(favouritesKey);
    if (jsonString == null) return [];

    final List<dynamic> decoded = json.decode(jsonString);
    return decoded.map((e) => e as int).toList();
  }

  @override
  Future<void> addFavourite(int pokemonId) async {
    final favourites = await getFavourites();
    if (!favourites.contains(pokemonId)) {
      favourites.add(pokemonId);
      await saveFavourites(favourites);
    }
  }

  @override
  Future<void> removeFavourite(int pokemonId) async {
    final favourites = await getFavourites();
    favourites.remove(pokemonId);
    await saveFavourites(favourites);
  }

  @override
  Future<bool> isFavourite(int pokemonId) async {
    final favourites = await getFavourites();
    return favourites.contains(pokemonId);
  }

  @override
  Future<void> saveThemeMode(bool isDarkMode) async {
    await sharedPreferences.setBool(themeModeKey, isDarkMode);
  }

  @override
  Future<bool> getThemeMode() async {
    return sharedPreferences.getBool(themeModeKey) ?? false;
  }
}
