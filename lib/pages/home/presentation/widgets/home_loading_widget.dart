import 'package:flutter/material.dart';
import 'package:hg_shopping_cart/core/util/widgets/loading.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Loading();
  }
}
