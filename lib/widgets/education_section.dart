import 'package:flutter/material.dart';
import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import 'reveal_on_scroll.dart';
import 'section_container.dart';

class EducationSection extends StatelessWidget {
  final Key sectionKey;
  const EducationSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      sectionKey: sectionKey,
      background: AppColors.surface.withOpacity(0.35),
      child: RevealOnScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(title: 'Education'),
            for (int i = 0; i < ProfileData.education.length; i++)
              _EducationTile(
                item: ProfileData.education[i],
                isLast: i == ProfileData.education.length - 1,
              ),
          ],
        ),
      ),
    );
  }
}

class _EducationTile extends StatelessWidget {
  final EducationItem item;
  final bool isLast;
  const _EducationTile({required this.item, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(top: 6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentGreen,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: AppColors.border),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: AppText.h3),
                    const SizedBox(height: 6),
                    Text(item.place,
                        style: AppText.bodySmall
                            .copyWith(color: AppColors.accentBlue)),
                    const SizedBox(height: 4),
                    Text(item.period, style: AppText.bodySmall),
                    const SizedBox(height: 10),
                    Text(item.description, style: AppText.body),
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