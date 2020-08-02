import 'package:flutter/material.dart';

class ExpandingSearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExpandingSearchBarState();
}

class _ExpandingSearchBarState extends State<ExpandingSearchBar> {
  static const double _appBarHeight = 56.0;
  static const Duration _animationDuration = Duration(milliseconds: 350);
  bool _isSearching = false;

  Widget _buildSearchBarChild(BuildContext context) {
    final double opacity = _isSearching ? 1.0 : 0.0;
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedOpacity(
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _isSearching
                  ? () {
                      setState(() {
                        _isSearching = false;
                      });
                    }
                  : null,
            ),
            opacity: opacity,
            duration: _animationDuration,
            curve: Curves.easeInOut,
          ),
          Text('Press me to search'),
          SizedBox(),
        ],
      ),
    );
  }

  Widget _buildDismissCanvas(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        width: size.width,
        height: size.height,
        color: Color.fromRGBO(0, 0, 0, 0.25),
      ),
      onTap: () {
        setState(() {
          _isSearching = false;
        });
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final double padding = _isSearching ? 0 : 16;
    final BorderRadius borderRadius = _isSearching
        ? BorderRadius.zero
        : BorderRadius.all(Radius.circular(8.0));
    final EdgeInsets margin =
        _isSearching ? EdgeInsets.zero : EdgeInsets.all(8.0);

    return GestureDetector(
      child: AnimatedContainer(
        margin: margin,
        width: MediaQuery.of(context).size.width - padding,
        height: _appBarHeight - padding,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: borderRadius,
        ),
        duration: _animationDuration,
        curve: Curves.easeInOut,
        child: Material(
          borderRadius: borderRadius,
          child: _buildSearchBarChild(context),
        ),
      ),
      onTap: () {
        setState(() {
          _isSearching = true;
        });
      },
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Search bar test'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        _buildScaffold(context),
        _buildDismissCanvas(context),
        _buildSearchBar(context),
      ],
    ));
  }
}
