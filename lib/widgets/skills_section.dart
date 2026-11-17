import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import 'reveal_on_scroll.dart';
import 'section_container.dart';

/// Logo for a skill. [slug] is the Devicon folder name; if it is null or the
/// image fails to load, [icon] + [color] are shown instead.
/// [white] tints dark logos (GitHub, Next.js...) white for the dark theme.
class _SkillVisual {
  final String? slug;
  final String variant;
  final bool white;
  final IconData icon;
  final Color color;
  const _SkillVisual({
    this.slug,
    this.variant = 'original',
    this.white = false,
    this.icon = Icons.code,
    this.color = AppColors.accentBlue,
  });

  String? get url => slug == null
      ? null
      : 'https://cdn.jsdelivr.net/gh/devicons/devicon@v2.16.0/icons/$slug/$slug-$variant.svg';
}

const Map<String, _SkillVisual> _skillVisuals = {
  // Programming languages
  'C': _SkillVisual(slug: 'c'),
  'Java': _SkillVisual(slug: 'java'),
  'Python': _SkillVisual(slug: 'python'),

  // Web
  'HTML5': _SkillVisual(slug: 'html5'),
  'CSS3': _SkillVisual(slug: 'css3'),
  'Sass': _SkillVisual(slug: 'sass'),
  'Bootstrap': _SkillVisual(slug: 'bootstrap'),
  'Tailwind CSS': _SkillVisual(slug: 'tailwindcss'),
  'React': _SkillVisual(slug: 'react'),
  'Next.js': _SkillVisual(slug: 'nextjs', white: true),
  'Angular': _SkillVisual(slug: 'angularjs'),

  // Mobile
  'Flutter': _SkillVisual(slug: 'flutter'),
  'Dart': _SkillVisual(slug: 'dart'),
  'Android': _SkillVisual(slug: 'android'),
  'React Native': _SkillVisual(slug: 'react'),
  'SwiftUI': _SkillVisual(slug: 'swift'),

  // Databases
  'MySQL': _SkillVisual(slug: 'mysql'),
  'PostgreSQL': _SkillVisual(slug: 'postgresql'),
  'MongoDB': _SkillVisual(slug: 'mongodb'),
  'SQL Server': _SkillVisual(slug: 'microsoftsqlserver'),
  'SQLite': _SkillVisual(slug: 'sqlite'),
  'SQL': _SkillVisual(icon: Icons.storage, color: Color(0xFF4479A1)),

  // Backend as a Service
  'Firebase': _SkillVisual(slug: 'firebase'),
  'Supabase': _SkillVisual(slug: 'supabase'),
  'Firestore':
      _SkillVisual(icon: Icons.local_fire_department, color: Color(0xFFFFCA28)),
  'Firebase Auth':
      _SkillVisual(icon: Icons.verified_user, color: Color(0xFFFFA000)),

  // Version control
  'Git': _SkillVisual(slug: 'git'),
  'GitHub': _SkillVisual(slug: 'github', white: true),
  'GitLab': _SkillVisual(slug: 'gitlab'),

  // APIs & integration
  'Postman': _SkillVisual(slug: 'postman'),
  'OpenAPI': _SkillVisual(icon: Icons.api, color: Color(0xFF6BA539)),
  'GraphQL': _SkillVisual(slug: 'graphql'),
  'JSON': _SkillVisual(icon: Icons.data_object, color: Color(0xFFFFCA28)),
  'XML': _SkillVisual(icon: Icons.code, color: Color(0xFFFF6C37)),
  'Swagger': _SkillVisual(slug: 'swagger'),

  // Dev tools
  'Android Studio': _SkillVisual(slug: 'androidstudio'),
  'VS Code': _SkillVisual(slug: 'vscode'),
  'IntelliJ IDEA': _SkillVisual(slug: 'intellij'),
  'npm': _SkillVisual(slug: 'npm', variant: 'original-wordmark'),
};

const _SkillVisual _fallbackVisual = _SkillVisual();

class SkillsSection extends StatelessWidget {
  final Key sectionKey;
  const SkillsSection({super.key, required this.sectionKey});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      sectionKey: sectionKey,
      background: AppColors.surface.withOpacity(0.35),
      child: RevealOnScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(title: 'Skills'),
            for (final category in ProfileData.skillCategories) ...[
              Text(
                category.title,
                style: AppText.h3.copyWith(
                  fontSize: 16,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final skill in category.skills)
                    _SkillChip(
                      label: skill,
                      visual: _skillVisuals[skill] ?? _fallbackVisual,
                    ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ],
        ),
      ),
    );
  }
}

class _SkillLogo extends StatelessWidget {
  final _SkillVisual visual;
  const _SkillLogo({required this.visual});

  Widget _fallback() => Icon(visual.icon, size: 20, color: visual.color);

  @override
  Widget build(BuildContext context) {
    final url = visual.url;
    if (url == null) return _fallback();

    return SvgPicture.network(
      url,
      width: 22,
      height: 22,
      colorFilter: visual.white
          ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
          : null,
      placeholderBuilder: (_) => const SizedBox(width: 22, height: 22),
      errorBuilder: (_, __, ___) => _fallback(),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String label;
  final _SkillVisual visual;
  const _SkillChip({required this.label, required this.visual});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _hover ? 1.06 : 1.0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: _hover ? AppColors.surfaceAlt : AppColors.surface,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _hover ? AppColors.accentGreen : AppColors.border,
            ),
            boxShadow: _hover
                ? [
                    BoxShadow(
                      color: AppColors.accentGreen.withOpacity(0.18),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SkillLogo(visual: widget.visual),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: AppText.h3.copyWith(
                  fontSize: 14.5,
                  color: _hover ? AppColors.accentGreen : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
