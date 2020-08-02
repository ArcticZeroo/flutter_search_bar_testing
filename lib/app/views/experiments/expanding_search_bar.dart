import 'package:flutter/material.dart';
import 'package:flutter_search_bar_testing/app/widgets/search/dismissible_sheet.dart';
import 'package:flutter_search_bar_testing/util/StringUtil.dart';

class ExpandingSearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExpandingSearchBarState();
}

class _ExpandingSearchBarState extends State<ExpandingSearchBar> {
  /// note: this will not always be true, in the case of AppBar having a bottom
  static const double _appBarHeight = 56.0;
  static const Duration _animationDuration = Duration(milliseconds: 350);
  bool _isSearching = false;
  String _query = StringUtil.empty;
  TextEditingController _textController;
  FocusNode _textFocus;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textFocus = FocusNode();
  }

  @override
  void dispose() {
    _textFocus.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    setState(() {
      _query = _textController.text;
    });
  }

  void stopSearch() {
    if (_isSearching) {
      _textController.removeListener(_onControllerChanged);
      _textFocus.unfocus();
      setState(() {
        _isSearching = false;
      });
    }
  }

  void startSearch() {
    if (!_isSearching) {
      _textController.addListener(_onControllerChanged);
      setState(() {
        _isSearching = true;
      });
      _textFocus.requestFocus();
    }
  }

  Widget _buildSearchBarTextField(BuildContext context) {
    return TextField(
      readOnly: !_isSearching,
      textInputAction: TextInputAction.search,
      controller: _textController,
      focusNode: _textFocus,
      onTap: startSearch,
      onSubmitted: (query) {
        stopSearch();
      },
      decoration: InputDecoration(hintText: 'Search'),
    );
  }

  Widget _buildVisibleWhenSearchingButton(
      IconData iconData, VoidCallback onPressed) {
    final double opacity = _isSearching ? 1.0 : 0.0;
    return AnimatedOpacity(
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: _isSearching ? stopSearch : null,
      ),
      opacity: opacity,
      duration: _animationDuration,
      curve: Curves.easeInOut,
    );
  }

  Widget _buildSearchBarChild(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildVisibleWhenSearchingButton(
              Icons.arrow_back, _isSearching ? stopSearch : null),
          Expanded(
            key: ValueKey('searchTextBox'),
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: _buildSearchBarTextField(context),
            ),
          ),
          // keeps the text centered due to space-between
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: _query.isEmpty
                ? null
                : () {
                    _textController.clear();
                    if (_isSearching) {
                      _textFocus.requestFocus();
                    } else {
                      startSearch();
                    }
                  },
          ),
        ],
      ),
    );
  }

  Widget _buildDismissCanvas(BuildContext context) {
    return DismissibleSheet(
      key: ValueKey('dismiss'),
      duration: _animationDuration,
      onTap: stopSearch,
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
      key: ValueKey('searchBar'),
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
      onTap: null,
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      key: ValueKey('scaffold'),
      appBar: AppBar(),
      body: Center(
        child: Text('Search bar test'),
      ),
    );
  }

  Widget _buildStack(BuildContext context) {
    List<Widget> children = [_buildScaffold(context)];

    if (_isSearching) {
      children.add(_buildDismissCanvas(context));
    }

    children.add(_buildSearchBar(context));

    return Stack(
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _buildStack(context),
    );
  }
}
