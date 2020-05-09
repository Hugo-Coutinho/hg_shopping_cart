import 'package:flutter/cupertino.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:lottie/lottie.dart';

class ShoppingCartEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        Constant.emptyAsset,
        width: 200,
        height: 200,
        fit: BoxFit.fill,
      ),
    );
  }
}
