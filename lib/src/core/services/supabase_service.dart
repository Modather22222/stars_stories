import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/story_model.dart';

class SupabaseService {
  static final SupabaseClient _client = Supabase.instance.client;

  // Fetch all stories
  static Future<List<StoryModel>> getStories() async {
    try {
      final response = await _client
          .from('stories')
          .select()
          .order('created_at', ascending: false);
      
      return (response as List)
          .map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load stories: $e');
    }
  }

  // Fetch stories by category
  static Future<List<StoryModel>> getStoriesByCategory(String category) async {
    try {
      final response = await _client
          .from('stories')
          .select()
          .eq('category', category)
          .order('created_at', ascending: false);
      
      return (response as List)
          .map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load stories for category $category: $e');
    }
  }

  // Fetch recent stories (limit 5)
  static Future<List<StoryModel>> getRecentStories() async {
    try {
      final response = await _client
          .from('stories')
          .select()
          .order('created_at', ascending: false)
          .limit(5);
      
      return (response as List)
          .map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load recent stories: $e');
    }
  }

  // Fetch story details (if needed separately, though we usually get full object)
  static Future<StoryModel> getStoryDetails(int id) async {
    try {
      final response = await _client
          .from('stories')
          .select()
          .eq('id', id)
          .single();
      
      return StoryModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load story details: $e');
    }
  }
}
