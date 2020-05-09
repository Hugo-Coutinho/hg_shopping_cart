import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class ShoppingCartEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lottie/9091-empty-sad-shopping-bag.json',
        width: 200,
        height: 200,
        fit: BoxFit.fill,
      ),
    );
  }
}
