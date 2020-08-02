import 'package:flutter/material.dart';
import 'package:flutter_search_bar_testing/app/views/experiments/expanding_search_bar.dart';
import 'package:flutter_search_bar_testing/app/views/experiments/sliding_search_bar.dart';
import 'package:flutter_search_bar_testing/util/ListUtil.dart';

class HomeView extends StatelessWidget {
  Widget _buildTestButton(
      BuildContext context, String name, WidgetBuilder builder) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: builder));
      },
      child: Text(
        name,
        style: Theme.of(context).primaryTextTheme.bodyText2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Search Bar Testing'),
        ),
        body: Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: ListUtil.separate(
                    [
                      Text(
                        'Search Bar Experiments',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      _buildTestButton(context, 'ExpandingSearchBar',
                          (_) => ExpandingSearchBar()),
                      _buildTestButton(context, 'SlidingSearchBar',
                          (_) => SlidingSearchBar()),
                    ],
                    () => SizedBox(
                          height: 16.0,
                        )),
              ),
            ),
          ),
        ),
      );
}
