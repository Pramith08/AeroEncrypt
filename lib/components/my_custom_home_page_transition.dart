import 'package:flutter/material.dart';

class MyCustomHomePageRoute extends PageRouteBuilder {
  final Widget enterWidget;

  MyCustomHomePageRoute(this.enterWidget)
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => enterWidget,
          opaque: false,
          transitionDuration: Duration(milliseconds: 200),
          reverseTransitionDuration: Duration(milliseconds: 150),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation = CurvedAnimation(
                parent: animation,
                curve: Curves.fastEaseInToSlowEaseOut,
                reverseCurve: Curves.fastEaseInToSlowEaseOut);
            final position = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation);
            return SlideTransition(
              position: position,
              child: child,
            );
          },
        );
}
