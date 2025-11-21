import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header
            const Text(
              'البحث',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
              ),
            ),
            const SizedBox(height: 24),

            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _searchQuery.isNotEmpty ? AppTheme.primaryColor : Colors.grey.withValues(alpha: 0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'ابحث عن قصة',
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: _searchQuery.isNotEmpty ? AppTheme.primaryColor : AppTheme.greyText,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Content
            Expanded(
              child: _searchQuery.isEmpty
                  ? _buildEmptyState()
                  : _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.searchPlaceholder,
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 24),
          const Text(
            'ابحث عن قصتك المفضلة',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'اكتب اسم القصة أو الشخصية للبحث عنها',
            style: TextStyle(
              color: AppTheme.greyText,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    // Mock results for demonstration
    final results = [
      {'title': 'علاء الدين والمصباح السحري', 'image': AppAssets.storyAladdin, 'rating': 4.8},
      {'title': 'علاء الدين والمصباح السحري', 'image': AppAssets.storyAladdin, 'rating': 4.8},
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final story = results[index];
        return _buildStoryCard(
          context,
          story['title'] as String,
          story['image'] as String,
          story['rating'] as double,
        );
      },
    );
  }

  Widget _buildStoryCard(BuildContext context, String title, String imagePath, double rating) {
    return GestureDetector(
      onTap: () {
        context.push('/story-details', extra: {
          'title': title,
          'imagePath': imagePath,
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),
            // Rating
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Title
            Positioned(
              bottom: 16,
              right: 12,
              left: 12,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
