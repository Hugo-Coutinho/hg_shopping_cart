import 'package:flutter/material.dart';

class HomeWithErrorWidget extends StatelessWidget {
  const HomeWithErrorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: Text("HomeWithErrorWidget"),
      ),
    );
  }
}
