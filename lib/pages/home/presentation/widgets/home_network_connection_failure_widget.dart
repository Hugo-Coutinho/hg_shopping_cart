import 'package:flutter/material.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:lottie/lottie.dart';

class HomeNetworkConnectionFailureWidget extends StatelessWidget {
  const HomeNetworkConnectionFailureWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      Constant.networkErrorAsset,
      width: 200,
      height: 200,
      fit: BoxFit.fill,
    );
  }
}
