import 'package:flutter/material.dart';

class AnimatedTap extends StatefulWidget {
  const AnimatedTap({
    super.key,
    this.onTap,
    required this.child,
  });
  final VoidCallback? onTap;
  final Widget child;

  @override
  State<AnimatedTap> createState() => _AnimatedTapState();
}

class _AnimatedTapState extends State<AnimatedTap>
    with TickerProviderStateMixin {
  double scale = 1;
  late AnimationController controller;
  Animation? animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scale = 1 - controller.value;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (tap) {
        controller.forward();
      },
      onTapUp: (tap) {
        controller.reverse();
      },
      onTapCancel: () {
        controller.reverse();
      },
      child: Transform.scale(
        scale: scale,
        child: widget.child,
      ),
    );
  }
}
