import 'package:flutter/material.dart';

class DismissibleSheet extends StatefulWidget {
  final Duration duration;
  final VoidCallback onTap;

  DismissibleSheet({Key key, @required this.duration, @required this.onTap})
      : super(key: key);

  @override
  _DismissibleSheetState createState() => _DismissibleSheetState();
}

class _DismissibleSheetState extends State<DismissibleSheet>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = _controller.drive(Tween(begin: 0.0, end: 1.0));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSheet(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        width: size.width,
        height: size.height,
        color: Color.fromRGBO(0, 0, 0, 0.25),
      ),
      onTap: widget.onTap,
    );
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _animation,
        child: _buildSheet(context),
      );
}
