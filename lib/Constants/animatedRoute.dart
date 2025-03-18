import 'package:flutter/material.dart';

class AnimatedRoute {
  static Route createRouteRightToLeft(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start from the right side
        const end = Offset(0.0, 0.0); // End at the center
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 500), // Adjust duration here (700ms)
    );
  }
}