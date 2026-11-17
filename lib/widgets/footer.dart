import 'package:flutter/material.dart';
import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import 'social_icons.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.center,
        children: [
          Text(
            '© 2026 ${ProfileData.name} — Built with Flutter.',
            style: AppText.bodySmall,
          ),
          if (isMobile) const SizedBox(height: 16),
          const SocialIcons(),
        ],
      ),
    );
  }
}