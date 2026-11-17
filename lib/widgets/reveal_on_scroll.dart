import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Fades + slides its [child] into view the first time it scrolls into the
/// viewport. Pure-Flutter implementation (no external animation package),
/// so it works without pub.dev access.
class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _visible = false;
  ScrollPosition? _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newPosition = Scrollable.maybeOf(context)?.position;
    if (newPosition != _position) {
      _position?.removeListener(_checkVisibility);
      _position = newPosition;
      _position?.addListener(_checkVisibility);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  @override
  void dispose() {
    _position?.removeListener(_checkVisibility);
    super.dispose();
  }

  void _checkVisibility() {
    if (_visible || !mounted) return;
    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.attached) return;

    final position = renderObject.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;

    if (position.dy < screenHeight * 0.9) {
      if (widget.delay == Duration.zero) {
        setState(() => _visible = true);
      } else {
        Future.delayed(widget.delay, () {
          if (mounted) setState(() => _visible = true);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _visible ? Offset.zero : const Offset(0, 0.08),
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}