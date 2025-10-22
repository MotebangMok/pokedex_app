
abstract class LocalDataSource {
  Future<void> saveFavourites(List<int> pokemonIds);
  Future<List<int>> getFavourites();
  Future<void> addFavourite(int pokemonId);
  Future<void> removeFavourite(int pokemonId);
  Future<bool> isFavourite(int pokemonId);

  Future<void> saveThemeMode(bool isDark);
  Future<bool> getThemeMode();
}