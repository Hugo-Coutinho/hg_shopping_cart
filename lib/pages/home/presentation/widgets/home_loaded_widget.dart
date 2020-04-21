import 'package:flutter/material.dart';

class HomeLoadedWidget extends StatefulWidget {
  @override
  _HomeLoadedWidgetState createState() => _HomeLoadedWidgetState();
}

class _HomeLoadedWidgetState extends State<HomeLoadedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: Text("HomeLoadedWidget"),
      ),
    );
  }
}
