import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/supabase_service.dart';
import '../../core/services/favorites_service.dart';
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
  bool _isFavorite = false;
  bool _isLoadingFavorite = true;

  @override
  void initState() {
    super.initState();
    _storyFuture = SupabaseService.getStoryDetails(widget.id);
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final isFav = await FavoritesService.isFavorite(widget.id);
    setState(() {
      _isFavorite = isFav;
      _isLoadingFavorite = false;
    });
  }

  Future<void> _toggleFavorite() async {
    final newStatus = await FavoritesService.toggleFavorite(widget.id);
    setState(() {
      _isFavorite = newStatus;
    });

    if (mounted) {
      _showCustomNotification(
        context,
        newStatus ? 'تم الإضافة إلى المفضلة' : 'تم الإزالة من المفضلة',
        newStatus ? Icons.favorite : Icons.favorite_border,
        newStatus ? AppTheme.primaryColor : Colors.grey,
      );
    }
  }

  void _showCustomNotification(
    BuildContext context,
    String message,
    IconData icon,
    Color color,
  ) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 300),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
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
          _isLoadingFavorite
              ? const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : IconButton(
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: _toggleFavorite,
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
                  allowHalfRating: false,
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
