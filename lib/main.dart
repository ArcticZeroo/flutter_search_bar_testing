import 'package:flutter/material.dart';
import 'package:flutter_search_bar_testing/app/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Bar Testing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme:
          ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
      home: HomeView(),
    );
  }
}
