import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Waits until the animation is over before performing any transformations,
/// at which point the entire transformation is applied at once. This is
/// basically a "delay" on an animation when used in an Animated widget
class DelayedInstantCurve extends Curve {
  @override
  double transform(double t) => t.floorToDouble();
}

class SlidingSearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SlidingSearchBarState();
}

class _SlidingSearchBarState extends State<SlidingSearchBar> {
  Duration _animationDuration = Duration(milliseconds: 350);
  bool _isSearchEnabled = false;

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _isSearchEnabled ? 0.0 : 1.0,
          duration: _animationDuration,
          child: Text('Search Bar Test'),
          curve: DelayedInstantCurve(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [_buildScaffold(context)],
      ),
    );
  }
}
