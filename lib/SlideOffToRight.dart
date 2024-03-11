import 'package:flutter/material.dart';

class SlideOffToRight extends PageRouteBuilder {
  final Widget parent;
  final Widget target;

  SlideOffToRight({required this.target, required this.parent})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) => target,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return Stack(
              children: [
                child,
                SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset.zero,
                    end: const Offset(1,0),
                  ).animate(animation),
                  child: parent
                )
              ]
            );
          },
      );
}