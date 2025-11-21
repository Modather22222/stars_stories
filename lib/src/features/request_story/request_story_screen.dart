import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class RequestStoryScreen extends StatelessWidget {
  const RequestStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'طلب قصة',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppTheme.darkText,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '"ركن الإبداع للأطفال"',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'يتيح هذا القسم للأطفال فرصة كتابة قصصهم الخاصة، مما يعزز الإبداع والخيال. يحدد الطفل الفكرة الأساسية للقصة، الأحداث الرئيسية، والشخصية البطلة والتي ممكن أن تكون باسمه، ونحن نتكفل بتحويل هذه الأفكار إلى قصة مصورة رائعة تضاف إلى التطبيق.',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.greyText,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),

            _buildLabel('اسم القصة'),
            _buildTextField('هنا اسم القصة'),
            const SizedBox(height: 24),

            _buildLabel('بطل القصة'),
            _buildTextField(''),
            const SizedBox(height: 24),

            _buildLabel('الفكرة الأساسية والأحداث'),
            _buildTextField('', maxLines: 5),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  shadowColor: AppTheme.primaryColor.withValues(alpha: 0.4),
                ),
                child: const Text(
                  'إرسال',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppTheme.darkText,
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding: const EdgeInsets.all(16),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
