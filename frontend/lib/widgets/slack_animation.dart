import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SlackLogoAnimation extends StatefulWidget {
  final double sw;

  const SlackLogoAnimation({super.key, required this.sw});

  @override
  SlackLogoAnimationState createState() => SlackLogoAnimationState();
}

class SlackLogoAnimationState extends State<SlackLogoAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    // Listen for animation completion
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.stop(); // Stop when animation finishes
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "lib/assets/animations/slack.json",
      controller: _controller,
      onLoaded: (composition) {
        _controller
          ..duration = composition.duration // pause at last frame instead of looping
          ..forward();
      },
      height: widget.sw * 0.4, 
    );
  }
}

