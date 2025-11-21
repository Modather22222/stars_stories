import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../core/theme/app_theme.dart';

class StoryDetailsScreen extends StatelessWidget {
  final String title;
  final String imagePath;

  const StoryDetailsScreen({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppTheme.darkText,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Story Content Loop
            ...List.generate(10, (index) {
              return Column(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                      image: DecorationImage(
                        image: AssetImage(imagePath), // Reusing the cover for now
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربي حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التي يولدها التطبيق. الفقرة رقم ${index + 1}.',
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.8,
                      color: AppTheme.darkText,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 32),
                ],
              );
            }),

            const Divider(height: 40),

            // Rating Section
            const Text(
              'تقييم القصة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
              ),
            ),
            const SizedBox(height: 16),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                // Handle rating update
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
