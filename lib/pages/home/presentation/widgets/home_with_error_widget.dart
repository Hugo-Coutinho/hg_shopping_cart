import 'package:flutter/material.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:lottie/lottie.dart';

class HomeWithErrorWidget extends StatelessWidget {
  final String message;

  HomeWithErrorWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: <Widget>[
        Text(message),
        Lottie.asset(
          Constant.failureAsset,
          width: 200,
          height: 200,
          fit: BoxFit.fill,
        )
      ],
    );
  }
}
