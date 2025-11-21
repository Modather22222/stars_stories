import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_theme.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الأقسام',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppTheme.darkText,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.85,
          children: [
            _buildCategoryCard(context, 'قصص خيالية', AppAssets.catFantasy, const Color(0xFFFFF4E6)),
            _buildCategoryCard(context, 'قصص تربوية', AppAssets.catEducational, const Color(0xFFE6F4FF)),
            _buildCategoryCard(context, 'قصص إسلامية', AppAssets.catIslamic, const Color(0xFFE6FFF2)),
            _buildCategoryCard(context, 'قصص تعليمية', AppAssets.catEducational, const Color(0xFFFFF0F5)), // Reusing educational icon for now
            _buildCategoryCard(context, 'قصص الأنبياء', AppAssets.catProphets, const Color(0xFFF0F0FF)),
            _buildCategoryCard(context, 'قصص هادفة', AppAssets.catPurposeful, const Color(0xFFFFF9E6)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, String imagePath, Color bgColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkText,
            ),
          ),
        ],
      ),
    );
  }
}
