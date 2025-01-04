import 'package:flutter/material.dart';

class AnimatedTransitions {
  static Route createSlideTransition(Widget page,
      {Offset begin = const Offset(1.0, 0.0),
      Curve curve = Curves.easeInOut,
      Duration duration = const Duration(milliseconds: 300)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: begin, end: Offset.zero)
            .chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  static Route createFadeTransition(Widget page,
      {Curve curve = Curves.easeInOut,
      Duration duration = const Duration(milliseconds: 300)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
        var fadeAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: fadeAnimation,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  static Route createScaleTransition(Widget page,
      {Curve curve = Curves.easeInOut,
      Duration duration = const Duration(milliseconds: 300)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: 0.8, end: 1.0).chain(CurveTween(curve: curve));
        var scaleAnimation = animation.drive(tween);

        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }
}
