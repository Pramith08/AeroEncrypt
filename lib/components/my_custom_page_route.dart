import 'package:flutter/material.dart';

class MyCustomPageRoute extends PageRouteBuilder {
  final Widget enterWidget;

  MyCustomPageRoute(this.enterWidget)
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => enterWidget,
          opaque: false,
          transitionDuration: Duration(milliseconds: 500),
          reverseTransitionDuration: Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation = CurvedAnimation(
                parent: animation,
                curve: Curves.fastEaseInToSlowEaseOut,
                reverseCurve: Curves.fastOutSlowIn);
            final opacity = Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation);

            return FadeTransition(
              opacity: opacity,
              child: child,
            );
          },
        );
}
