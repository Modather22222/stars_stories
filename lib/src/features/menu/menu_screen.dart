import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';



class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header
            const Text(
              'القائمة',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
              ),
            ),
            const SizedBox(height: 24),

            // Menu Items
            _buildMenuItem(
              context,
              'المفضلة',
              Icons.favorite,
              Colors.red,
              () => context.push('/favorites'),
            ),
            const SizedBox(height: 16),
            _buildMenuItem(
              context,
              'من نحن',
              Icons.info,
              Colors.red,
              () => context.push('/who-we-are'),
            ),
            const SizedBox(height: 16),
            _buildMenuItem(
              context,
              'رؤيتنا',
              Icons.lightbulb,
              Colors.red,
              () => context.push('/our-vision'),
            ),
            const SizedBox(height: 16),
            _buildMenuItem(
              context,
              'تواصل معنا',
              Icons.message,
              Colors.red,
              () => _showContactUsSheet(context),
            ),
            const SizedBox(height: 16),
            _buildMenuItem(
              context,
              'تقييم التطبيق',
              Icons.star,
              Colors.red,
              () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
            Icon(
              icon,
              color: iconColor,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppTheme.greyText,
            ),
          ],
        ),
      ),
    );
  }



  void _showContactUsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'تواصل معنا',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
              ),
            ),
            const SizedBox(height: 24),
            _buildContactButton(
              'الواتساب',
              FontAwesomeIcons.whatsapp,
              Colors.white,
              AppTheme.primaryColor,
              Colors.transparent,
            ),
            const SizedBox(height: 16),
            _buildContactButton(
              'الفيسبوك',
              FontAwesomeIcons.facebookF,
              AppTheme.primaryColor,
              const Color(0xFFFFF0F0),
              AppTheme.primaryColor,
            ),
            const SizedBox(height: 16),
            _buildContactButton(
              'البريد الإلكتروني',
              Icons.email_outlined, // Using Material icon for email as it matches design better usually
              AppTheme.primaryColor,
              const Color(0xFFFFF0F0),
              Colors.transparent,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildContactButton(
    String title,
    IconData icon,
    Color textColor,
    Color bgColor,
    Color borderColor,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: 8),
          Text(
            ' | $title',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
