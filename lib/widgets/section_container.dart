import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Centers content with a max width, and gives every section the same
/// horizontal/vertical padding rhythm.
class SectionContainer extends StatelessWidget {
  final Widget child;
  final Color? background;
  final Key? sectionKey;

  const SectionContainer({
    super.key,
    this.sectionKey,
    required this.child,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double horizontalPadding;
    if (AppBreakpoints.isDesktop(width)) {
      final extra = ((width - 1100) / 2).clamp(24.0, 400.0);
      horizontalPadding = extra + 24;
    } else if (AppBreakpoints.isTablet(width)) {
      horizontalPadding = 48.0;
    } else {
      horizontalPadding = 20.0;
    }

    return Container(
      key: sectionKey,
      width: double.infinity,
      color: background,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 64,
      ),
      child: child,
    );
  }
}

/// Small heading with the signature underline accent used across the site.
class SectionHeading extends StatelessWidget {
  final String title;

  const SectionHeading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppText.h1),
        const SizedBox(height: 10),
        Container(
          width: 56,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}