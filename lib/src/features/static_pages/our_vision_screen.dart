import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_theme.dart';

class OurVisionScreen extends StatelessWidget {
  const OurVisionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEF3349), // Primary Red
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'رؤيتنا',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Top Image
          Center(
            child: Image.asset(
              AppAssets.splashLogo,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 40),
          // Content Container
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text(
                      '"كل قصة نجمة تضيء خيال طفلك"',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'في "حكايات نجوم"، نؤمن أن كل قصة هي بمثابة نجمة تتلألأ في سماء خيال الطفل، تضيء عالمه بالمعرفة والإبداع. رؤيتنا هي بناء جسر من القصص العربية الغنية والهادفة بين الآباء وأطفالهم، مما يفتح باباً واسعاً للحوار والتواصل الأسري. نقدم في تطبيقنا قصصاً مختارة بعناية، مصحوبة برسومات كرتونية مميزة، ليس فقط لتسلية الأطفال، بل لتعليمهم القيم الأخلاقية والسلوك الحسن.\n\nنسعى في "حكايات نجوم" لأن نكون مصدر إلهام دائم للأطفال وأولياء أمورهم.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.greyText,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
