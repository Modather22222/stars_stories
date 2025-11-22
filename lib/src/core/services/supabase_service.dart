import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/story_model.dart';

class SupabaseService {
  static final SupabaseClient _client = Supabase.instance.client;

  // Fetch all stories
  // Fetch all stories with caching
  static Future<List<StoryModel>> getStories() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      const String cacheKey = 'stories_all';

      // 1. Try to get from cache first
      if (prefs.containsKey(cacheKey)) {
        final String? cachedJson = prefs.getString(cacheKey);
        if (cachedJson != null) {
          // Return cached data immediately, but trigger background refresh if needed
          // For simplicity, we return cached data if fetch fails later
        }
      }

      final response = await _client
          .from('stories')
          .select()
          .order('created_at', ascending: false);
      
      // Save to cache
      await prefs.setString(cacheKey, jsonEncode(response));

      return (response as List)
          .map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // If fetch fails, try to return cached data
      final prefs = await SharedPreferences.getInstance();
      const String cacheKey = 'stories_all';
      if (prefs.containsKey(cacheKey)) {
        final String? cachedJson = prefs.getString(cacheKey);
        if (cachedJson != null) {
          final List<dynamic> decoded = jsonDecode(cachedJson);
          return decoded
              .map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }
      throw Exception('Failed to load stories: $e');
    }
  }

  // Fetch stories by category
  // Fetch stories by category with caching
  static Future<List<StoryModel>> getStoriesByCategory(String category) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String cacheKey = 'stories_cat_$category';

      final response = await _client
          .from('stories')
          .select()
          .eq('category', category)
          .order('created_at', ascending: false);
      
      // Save to cache
      await prefs.setString(cacheKey, jsonEncode(response));

      return (response as List)
          .map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // If fetch fails, try to return cached data
      final prefs = await SharedPreferences.getInstance();
      final String cacheKey = 'stories_cat_$category';
      if (prefs.containsKey(cacheKey)) {
        final String? cachedJson = prefs.getString(cacheKey);
        if (cachedJson != null) {
          final List<dynamic> decoded = jsonDecode(cachedJson);
          return decoded
              .map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }
      throw Exception('Failed to load stories for category $category: $e');
    }
  }

  // Fetch recent stories (limit 5)
  // Fetch recent stories (limit 5) with caching
  static Future<List<StoryModel>> getRecentStories() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      const String cacheKey = 'stories_recent';

      final response = await _client
          .from('stories')
          .select()
          .order('created_at', ascending: false)
          .limit(5);
      
      // Save to cache
      await prefs.setString(cacheKey, jsonEncode(response));

      return (response as List)
          .map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // If fetch fails, try to return cached data
      final prefs = await SharedPreferences.getInstance();
      const String cacheKey = 'stories_recent';
      if (prefs.containsKey(cacheKey)) {
        final String? cachedJson = prefs.getString(cacheKey);
        if (cachedJson != null) {
          final List<dynamic> decoded = jsonDecode(cachedJson);
          return decoded
              .map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }
      throw Exception('Failed to load recent stories: $e');
    }
  }

  // Fetch story details (if needed separately, though we usually get full object)
  // Fetch story details with caching
  static Future<StoryModel> getStoryDetails(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String cacheKey = 'story_details_$id';

      // 1. Try to get from cache first
      if (prefs.containsKey(cacheKey)) {
        final String? cachedJson = prefs.getString(cacheKey);
        if (cachedJson != null) {
          return StoryModel.fromJson(jsonDecode(cachedJson));
        }
      }

      // 2. If not in cache, fetch from Supabase
      final response = await _client
          .from('stories')
          .select()
          .eq('id', id)
          .single();
      
      // 3. Save to cache
      await prefs.setString(cacheKey, jsonEncode(response));
      
      return StoryModel.fromJson(response);
    } catch (e) {
      // If fetch fails and we didn't have it in cache (or cache read failed), throw error
      throw Exception('Failed to load story details: $e');
    }
  }
}
