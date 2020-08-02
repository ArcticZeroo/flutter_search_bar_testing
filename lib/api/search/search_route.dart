import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// TODO: configuration
class SearchRoute extends PopupRoute {
  /// Builds the search box
  final WidgetBuilder builder;

  /// Whether tapping outside the search box can close the search box
  final bool isDismissable;

  /// Used for screen readers to give a name to the tappable barrier that can
  /// dismiss the search box
  final String dismissAreaLabel;

  /// The color shown behind the search bar
  final Color dismissAreaColor;

  /// How long the "opening transition" (when the search is first opened)
  /// plays for.
  final Duration openTransitionDuration;

  SearchRoute(
      {@required this.builder,
      this.isDismissable = true,
      this.dismissAreaLabel = 'tap to close search',
      this.dismissAreaColor = const Color.fromRGBO(0, 0, 0, 0.25),
      this.openTransitionDuration = const Duration(milliseconds: 750)});

  @override
  Color get barrierColor => dismissAreaColor;

  @override
  bool get barrierDismissible => isDismissable;

  @override
  String get barrierLabel => dismissAreaLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      builder(context);

  @override
  Duration get transitionDuration => openTransitionDuration;

  @override
  get currentResult => null;
}
