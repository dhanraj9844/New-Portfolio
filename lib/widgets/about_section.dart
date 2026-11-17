import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import 'reveal_on_scroll.dart';
import 'section_container.dart';

class AboutSection extends StatelessWidget {
  final Key sectionKey;
  const AboutSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      sectionKey: sectionKey,
      child: RevealOnScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(title: 'About'),
            Text(ProfileData.about, style: AppText.body),
            const SizedBox(height: 28),
            _ContactCallout(),
          ],
        ),
      ),
    );
  }
}

class _ContactCallout extends StatefulWidget {
  @override
  State<_ContactCallout> createState() => _ContactCalloutState();
}

class _ContactCalloutState extends State<_ContactCallout> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hover ? AppColors.accentGreen.withOpacity(0.5) : AppColors.border,
          ),
        ),
        child: Builder(builder: (context) {
          final textColumn = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'OPEN TO WORK',
                style: AppText.bodySmall.copyWith(
                  color: AppColors.accentGreen,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 6),
              Text('Freelancing on Flutter & full-stack projects', style: AppText.h3),
              const SizedBox(height: 8),
              Text(
                'Follow along on Instagram or reach out directly — happy to discuss your project.',
                style: AppText.bodySmall,
              ),
            ],
          );

          final button = ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentGreen,
              foregroundColor: const Color(0xFF06251D),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => launchUrl(Uri.parse(ProfileData.instagramUrl)),
            child: const Text('Open Instagram',
                style: TextStyle(fontWeight: FontWeight.w700)),
          );

          if (isMobile) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [textColumn, const SizedBox(height: 16), button],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: textColumn),
              const SizedBox(width: 20),
              button,
            ],
          );
        }),
      ),
    );
  }
}