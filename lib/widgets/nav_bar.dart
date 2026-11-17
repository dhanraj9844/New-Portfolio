import 'package:flutter/material.dart';
import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import 'social_icons.dart';

class NavItem {
  final String label;
  final VoidCallback onTap;
  const NavItem(this.label, this.onTap);
}

class NavBar extends StatefulWidget {
  final List<NavItem> items;

  const NavBar({super.key, required this.items});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _menuOpen = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(width);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.92),
        border: const Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.accentGradient.createShader(bounds),
                  child: const Text(
                    ProfileData.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                if (!isMobile) ...[
                  for (final item in widget.items) _NavLink(item: item),
                  const SizedBox(width: 20),
                  const SocialIcons(),
                ] else
                  IconButton(
                    onPressed: () => setState(() => _menuOpen = !_menuOpen),
                    icon: Icon(
                      _menuOpen ? Icons.close : Icons.menu,
                      color: AppColors.textPrimary,
                    ),
                  ),
              ],
            ),
          ),
          if (isMobile && _menuOpen)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  for (final item in widget.items)
                    _MobileNavLink(
                      item: item,
                      onTap: () {
                        setState(() => _menuOpen = false);
                        item.onTap();
                      },
                    ),
                  const SizedBox(height: 12),
                  const SocialIcons(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final NavItem item;
  const _NavLink({required this.item});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.item.onTap,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: AppText.nav.copyWith(
              color: _hover ? AppColors.accentGreen : AppColors.textSecondary,
            ),
            child: Text(widget.item.label),
          ),
        ),
      ),
    );
  }
}

class _MobileNavLink extends StatelessWidget {
  final NavItem item;
  final VoidCallback onTap;
  const _MobileNavLink({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(item.label, style: AppText.nav),
      ),
    );
  }
}