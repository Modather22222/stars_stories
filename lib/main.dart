import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'src/core/router/app_router.dart';
import 'src/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://ysdtyvfapwrmekmdsrcm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlzZHR5dmZhcHdybWVrbWRzcmNtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM2NzA2NTAsImV4cCI6MjA3OTI0NjY1MH0.GDZoA0MMiHDgg5xjmH-buRfbeKcKWd8ldaESMda3fEE',
  );

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const StarsStoriesApp());
}

class StarsStoriesApp extends StatelessWidget {
  const StarsStoriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Stars Stories',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}
