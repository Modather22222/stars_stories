import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/supabase_service.dart';
import '../../core/models/story_model.dart';
import '../request_story/request_story_screen.dart';
import '../search/search_screen.dart';
import '../menu/menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeContent(),
          const SearchScreen(),
          const RequestStoryScreen(),
          const MenuScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.navHome,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 0 ? AppTheme.primaryColor : Colors.grey,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.navSearch,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 1 ? AppTheme.primaryColor : Colors.grey,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            label: 'البحث',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.navAdd,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 2 ? AppTheme.primaryColor : Colors.grey,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            label: 'طلب قصة',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.navMenu,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 3 ? AppTheme.primaryColor : Colors.grey,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
            label: 'القائمة',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'مرحبا بك',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.darkText,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '👋',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const Text(
                        'اجعل طفلك يستمتع بالقصص الشيقة',
                        style: TextStyle(
                          color: AppTheme.greyText,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.nightlight_round,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Banner
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage(AppAssets.homeBanner),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 16,
                      top: 40,
                      child: SizedBox(
                        width: 150,
                        child: Text(
                          'كل قصة نجمة تضيء خيال طفلك',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            shadows: [
                              Shadow(
                                blurRadius: 4,
                                color: Colors.black45,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Categories Header
              _buildSectionHeader(context, 'الأقسام', 'عرض الكل', () {
                context.push('/categories');
              }),
              const SizedBox(height: 16),

              // Categories List
              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryCard(
                      'قصص تعليمية',
                      AppAssets.catEducational,
                      const Color(0xFFFFF4F4),
                    ),
                    const SizedBox(width: 16),
                    _buildCategoryCard(
                      'قصص إسلامية',
                      AppAssets.catIslamic,
                      const Color(0xFFF4FBF7),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Recently Added Header
              _buildSectionHeader(context, 'مضافة حديثاً', 'عرض الكل', () {
                context.push('/stories-list', extra: 'مضافة حديثاً');
              }),
              const SizedBox(height: 16),

              // Recently Added List (Supabase)
              SizedBox(
                height: 240,
                child: FutureBuilder<List<StoryModel>>(
                  future: SupabaseService.getRecentStories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Check if it's a network error (often contains "SocketException" or "Failed host lookup")
                      final error = snapshot.error.toString();
                      if (error.contains('SocketException') || error.contains('Failed host lookup')) {
                         return const Center(child: Text('لا يوجد اتصال بالإنترنت'));
                      }
                      return Center(child: Text('حدث خطأ غير متوقع'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('لا توجد قصص مضافة حديثاً'));
                    }

                    final stories = snapshot.data!;
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: stories.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final story = stories[index];
                        return _buildStoryCard(context, story);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, String action, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkText,
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Row(
            children: [
              Text(
                action,
                style: const TextStyle(
                  color: AppTheme.greyText,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: AppTheme.greyText,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String title, String imagePath, Color bgColor) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              imagePath,
              width: 60,
              height: 60,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryCard(BuildContext context, StoryModel story) {
    return GestureDetector(
      onTap: () => context.push(
        '/story-details',
        extra: {
          'id': story.id.toString(),
          'title': story.title,
          'imagePath': story.coverUrl,
        },
      ),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: story.coverUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) {
                  return Container(
                    height: 120,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    story.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppTheme.darkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    story.category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.greyText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '4.5', // Placeholder rating
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
