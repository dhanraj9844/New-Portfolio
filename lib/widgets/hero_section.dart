import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import 'section_container.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onSeeWork;
  final Key sectionKey;

  const HeroSection({
    super.key,
    required this.sectionKey,
    required this.onSeeWork,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);

    // ── Everything that used to be the direct child Column is now the
    // "text" half of the hero. The photo sits beside it on desktop, and
    // stacks above it on mobile. THIS is where the photo gets wired in.
    final textColumn = Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        const _AvailabilityBadge(),
        const SizedBox(height: 22),
        Text(
          "Hi, I'm ${ProfileData.name}",
          style: isMobile ? AppText.h1 : AppText.display,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            ProfileData.tagline,
            style: AppText.body,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          ProfileData.roles,
          style: AppText.bodySmall,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 26),
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final s in ['Flutter', 'React', 'Firebase', 'Python'])
              _PillTag(label: s),
          ],
        ),
        const SizedBox(height: 30),
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 14,
          runSpacing: 14,
          children: [
            _PrimaryButton(
              label: 'See my work',
              onTap: widget.onSeeWork,
            ),
            _SecondaryButton(
              label: 'Email me',
              onTap: () => launchUrl(Uri.parse('mailto:${ProfileData.email}')),
            ),
          ],
        ),
      ],
    );

    const photo = _ProfilePhoto();

    return SectionContainer(
      sectionKey: widget.sectionKey,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 320,
              height: 320,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.heroGlow,
              ),
            ),
          ),
          FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              // ↓↓↓ This is the actual layout change: was just
              // `child: Column(...)` before — now it branches so the
              // photo can sit next to (desktop) or above (mobile) the
              // text.
              child: isMobile
                  ? Column(
                      children: [
                        photo,
                        const SizedBox(height: 36),
                        textColumn,
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: textColumn),
                        const SizedBox(width: 40),
                        photo,
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ── THE PHOTO WIDGET ─────────────────────────────────────────────
/// Circular profile photo with a gradient ring + soft glow. Looks for
/// assets/profile.jpg — if it's not there yet (or not declared in
/// pubspec.yaml), it falls back to a "DK" initials avatar instead of
/// crashing, so the app always builds and runs.
class _ProfilePhoto extends StatefulWidget {
  const _ProfilePhoto();

  @override
  State<_ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<_ProfilePhoto>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const size = 260.0;

    return SizedBox(
      width: size + 30,
      height: size + 30,
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (context, child) {
          final glow = 20 + (_pulse.value * 14);
          return Center(
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.accentGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentGreen.withOpacity(0.28),
                    blurRadius: glow,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.background,
                ),
                child: ClipOval(
                  child: SizedBox(
                    width: size - 20,
                    height: size - 20,
                    // ← THIS LINE loads your photo. Path must match
                    // exactly where you put the file: assets/profile.jpg
                    child: Image.asset(
                      'assets/profile (2).jpeg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const _InitialsFallback(),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InitialsFallback extends StatelessWidget {
  const _InitialsFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.surfaceAlt, AppColors.surface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: ShaderMask(
        shaderCallback: (bounds) =>
            AppColors.accentGradient.createShader(bounds),
        child: const Text(
          'DK',
          style: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _AvailabilityBadge extends StatelessWidget {
  const _AvailabilityBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _PulsingDot(),
          const SizedBox(width: 8),
          Text(
            ProfileData.availability,
            style: AppText.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  const _PulsingDot();

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.4, end: 1.0).animate(_controller),
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.accentGreen,
        ),
      ),
    );
  }
}

class _PillTag extends StatelessWidget {
  final String label;
  const _PillTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: AppText.bodySmall.copyWith(fontSize: 12.5)),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hover ? 1.04 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: BorderRadius.circular(10),
              boxShadow: _hover
                  ? [
                      BoxShadow(
                        color: AppColors.accentGreen.withOpacity(0.35),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [],
            ),
            child: Text(
              widget.label,
              style: const TextStyle(
                color: Color(0xFF06251D),
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _SecondaryButton({required this.label, required this.onTap});

  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
          decoration: BoxDecoration(
            color: _hover ? AppColors.surfaceAlt : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            widget.label,
            style:
                AppText.h3.copyWith(fontSize: 15, color: AppColors.textPrimary),
          ),
        ),
      ),
    );
  }
}
