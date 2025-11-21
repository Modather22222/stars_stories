import 'package:go_router/go_router.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/home/categories_screen.dart';
import '../../features/home/stories_list_screen.dart';
import '../../features/story/story_details_screen.dart';
import '../../features/request_story/request_story_screen.dart';
import '../../features/favorites/favorites_screen.dart';
import '../../features/static_pages/who_we_are_screen.dart';
import '../../features/static_pages/our_vision_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: '/stories-list',
      builder: (context, state) {
        final title = state.extra as String? ?? 'قائمة القصص';
        return StoriesListScreen(title: title);
      },
    ),
    GoRoute(
      path: '/story-details',
      builder: (context, state) {
        final args = state.extra as Map<String, String>;
        return StoryDetailsScreen(
          title: args['title']!,
          imagePath: args['imagePath']!,
        );
      },
    ),
    GoRoute(
      path: '/request-story',
      builder: (context, state) => const RequestStoryScreen(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/who-we-are',
      builder: (context, state) => const WhoWeAreScreen(),
    ),
    GoRoute(
      path: '/our-vision',
      builder: (context, state) => const OurVisionScreen(),
    ),
  ],
);
