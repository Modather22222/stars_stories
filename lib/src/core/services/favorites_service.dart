import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_stories';

  // Get list of favorite story IDs
  static Future<List<int>> getFavoriteIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? favoriteStrings = prefs.getStringList(_favoritesKey);
      
      if (favoriteStrings == null) {
        return [];
      }
      
      return favoriteStrings.map((id) => int.parse(id)).toList();
    } catch (e) {
      return [];
    }
  }

  // Check if a story is favorite
  static Future<bool> isFavorite(int storyId) async {
    final favorites = await getFavoriteIds();
    return favorites.contains(storyId);
  }

  // Add story to favorites
  static Future<void> addFavorite(int storyId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = await getFavoriteIds();
      
      if (!favorites.contains(storyId)) {
        favorites.add(storyId);
        await prefs.setStringList(
          _favoritesKey,
          favorites.map((id) => id.toString()).toList(),
        );
      }
    } catch (e) {
      // Handle error silently
    }
  }

  // Remove story from favorites
  static Future<void> removeFavorite(int storyId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = await getFavoriteIds();
      
      favorites.remove(storyId);
      await prefs.setStringList(
        _favoritesKey,
        favorites.map((id) => id.toString()).toList(),
      );
    } catch (e) {
      // Handle error silently
    }
  }

  // Toggle favorite status
  static Future<bool> toggleFavorite(int storyId) async {
    final isFav = await isFavorite(storyId);
    
    if (isFav) {
      await removeFavorite(storyId);
      return false;
    } else {
      await addFavorite(storyId);
      return true;
    }
  }
}
