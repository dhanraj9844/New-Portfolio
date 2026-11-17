import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import 'reveal_on_scroll.dart';
import 'section_container.dart';

class ProjectsSection extends StatelessWidget {
  final Key sectionKey;
  const ProjectsSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final columns = AppBreakpoints.isDesktop(width)
        ? 3
        : AppBreakpoints.isTablet(width)
            ? 2
            : 1;

    return SectionContainer(
      sectionKey: sectionKey,
      child: RevealOnScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(title: 'Projects'),
            LayoutBuilder(
              builder: (context, constraints) {
                final cardWidth =
                    (constraints.maxWidth - (columns - 1) * 20) / columns;
                return Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    for (final project in ProfileData.projects)
                      SizedBox(
                        width: cardWidth,
                        child: _ProjectCard(project: project),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hover = false;

  bool get _hasLink => widget.project.url.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: _hasLink ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: _hasLink ? () => launchUrl(Uri.parse(widget.project.url)) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hover && _hasLink ? -6 : 0, 0),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hover && _hasLink
                  ? AppColors.accentGreen.withOpacity(0.6)
                  : AppColors.border,
            ),
            boxShadow: _hover && _hasLink
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.35),
                      blurRadius: 24,
                      offset: const Offset(0, 14),
                    ),
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      gradient: AppColors.accentGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.folder_open,
                        color: Color(0xFF06251D), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(widget.project.title, style: AppText.h3),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(widget.project.summary, style: AppText.bodySmall),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final tag in widget.project.tags) _Tag(label: tag),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Text(
                    _hasLink ? 'View on GitHub' : 'In Progress',
                    style: AppText.bodySmall.copyWith(
                      color: _hasLink
                          ? AppColors.accentGreen
                          : AppColors.textMuted,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (_hasLink) ...[
                    const SizedBox(width: 6),
                    AnimatedSlide(
                      duration: const Duration(milliseconds: 200),
                      offset: _hover ? const Offset(0.2, 0) : Offset.zero,
                      child: const Icon(Icons.arrow_forward,
                          size: 14, color: AppColors.accentGreen),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: AppText.bodySmall.copyWith(fontSize: 11.5, color: AppColors.textSecondary),
      ),
    );
  }
}
