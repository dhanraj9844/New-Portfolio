import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/profile_data.dart';
import '../theme/app_theme.dart';

class SocialIcons extends StatelessWidget {
  final double iconSize;

  const SocialIcons({super.key, this.iconSize = 18});

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialButton(
          icon: Icons.code,
          tooltip: 'GitHub',
          size: iconSize,
          onTap: () => _open(ProfileData.githubUrl),
        ),
        const SizedBox(width: 10),
        _SocialButton(
          icon: Icons.camera_alt_outlined,
          tooltip: 'Instagram',
          size: iconSize,
          onTap: () => _open(ProfileData.instagramUrl),
        ),
        const SizedBox(width: 10),
        _SocialButton(
          icon: Icons.mail_outline,
          tooltip: 'Email',
          size: iconSize,
          onTap: () => _open('mailto:${ProfileData.email}'),
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final double size;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.tooltip,
    required this.size,
    required this.onTap,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hover ? AppColors.accentGreen.withOpacity(0.15) : AppColors.surface,
              border: Border.all(
                color: _hover ? AppColors.accentGreen : AppColors.border,
              ),
            ),
            child: Icon(
              widget.icon,
              size: widget.size,
              color: _hover ? AppColors.accentGreen : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}