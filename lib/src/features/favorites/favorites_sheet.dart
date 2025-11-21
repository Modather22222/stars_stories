import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_theme.dart';

class FavoritesSheet extends StatefulWidget {
  const FavoritesSheet({super.key});

  @override
  State<FavoritesSheet> createState() => _FavoritesSheetState();
}

class _FavoritesSheetState extends State<FavoritesSheet> {
  // Mock data - set to empty list to show empty state initially
  final List<Map<String, dynamic>> _favorites = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          // Drag Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          // Title
          const Text(
            'المفضلة',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkText,
            ),
          ),
          const SizedBox(height: 16),
          
          // Content
          Flexible(
            child: _favorites.isEmpty ? _buildEmptyState() : _buildFavoritesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppAssets.favoritesPlaceholder,
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 24),
          const Text(
            'لم تضف اي قصة للمفضلة حتى الآن',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.greyText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 48),
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF5D5D), Color(0xFFFF3348)],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF3348).withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                context.pop(); // Close the bottom sheet
                context.go('/home'); // Navigate to Home
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'تصفح القصص',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildFavoritesList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      itemCount: _favorites.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final story = _favorites[index];
        return _buildFavoriteItem(story);
      },
    );
  }

  Widget _buildFavoriteItem(Map<String, dynamic> story) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              story['image'],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  story['category'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.greyText,
                  ),
                ),
              ],
            ),
          ),
          
          // Favorite Icon
          IconButton(
            icon: const Icon(Icons.favorite, color: Color(0xFFFF5D5D)),
            onPressed: () {
              // Remove from favorites logic
            },
          ),
        ],
      ),
    );
  }
}
