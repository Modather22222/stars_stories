import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/supabase_service.dart';
import '../../core/models/story_model.dart';

class StoryDetailsScreen extends StatefulWidget {
  final int id;
  final String title; // For initial display
  final String imagePath; // For initial display

  const StoryDetailsScreen({
    super.key,
    required this.id,
    required this.title,
    required this.imagePath,
  });

  @override
  State<StoryDetailsScreen> createState() => _StoryDetailsScreenState();
}

class _StoryDetailsScreenState extends State<StoryDetailsScreen> {
  late Future<StoryModel> _storyFuture;

  @override
  void initState() {
    super.initState();
    _storyFuture = SupabaseService.getStoryDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
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
      body: FutureBuilder<StoryModel>(
        future: _storyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Check if it's a network error
            final error = snapshot.error.toString();
            if (error.contains('SocketException') || error.contains('Failed host lookup')) {
               return const Center(child: Text('لا يوجد اتصال بالإنترنت'));
            }
            return const Center(child: Text('حدث خطأ غير متوقع'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('القصة غير موجودة'));
          }

          final story = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Story Content Loop
                ...story.pages.map((page) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: page.imageUrl,
                            fit: BoxFit.fitWidth,
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) {
                              // Fallback to cover image or placeholder if page image fails
                              return CachedNetworkImage(
                                imageUrl: widget.imagePath,
                                fit: BoxFit.fitWidth,
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                errorWidget: (c, e, s) => const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        page.text,
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
          );
        },
      ),
    );
  }
}
