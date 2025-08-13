import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:desafio_rick_morty/models/detailed_characters.dart';

class FavoritesManager {
  static const String _favoritesKey = 'favorites_characters';

  static Future<void> saveFavorites(List<DetailedCharacter> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = favorites.map((character) => character.toJson()).toList();
    await prefs.setString(_favoritesKey, jsonEncode(favoritesJson));
  }

  static Future<List<DetailedCharacter>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesString = prefs.getString(_favoritesKey);
    
    if (favoritesString == null) return [];
    
    final List<dynamic> favoritesJson = jsonDecode(favoritesString);
    return favoritesJson.map((json) => DetailedCharacter.fromJson(json)).toList();
  }

  static Future<void> addToFavorites(DetailedCharacter character) async {
    final favorites = await loadFavorites();
    
    if (!favorites.any((fav) => fav.id == character.id)) {
      favorites.add(character);
      await saveFavorites(favorites);
    }
  }

  static Future<void> removeFromFavorites(int characterId) async {
    final favorites = await loadFavorites();
    favorites.removeWhere((character) => character.id == characterId);
    await saveFavorites(favorites);
  }

  static Future<bool> isFavorite(int characterId) async {
    final favorites = await loadFavorites();
    return favorites.any((character) => character.id == characterId);
  }

  static Future<bool> toggleFavorite(DetailedCharacter character) async {
    final isFav = await isFavorite(character.id);
    
    if (isFav) {
      await removeFromFavorites(character.id);
      return false;
    } else {
      await addToFavorites(character);
      return true;
    }
  }
}
