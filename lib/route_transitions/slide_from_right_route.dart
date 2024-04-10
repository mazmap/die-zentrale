import 'package:flutter/material.dart';

class SlideFromRightRoute extends PageRouteBuilder {
  final Widget page;
  final RouteSettings? routeSettings;

  SlideFromRightRoute({required this.page, this.routeSettings})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
    ) => page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
    ) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    settings: routeSettings
  );
}