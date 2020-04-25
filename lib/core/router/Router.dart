import 'package:flutter/material.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/pages/home/presentation/HomePage.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/presentation/shopping_cart.dart';

class Router {
  String getInitialRoute() {
    return Constant.homePage;
  }

  Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      Constant.homePage: (context) => HomePage(),
      Constant.shoppingCartPage: (context) => ShoppingCart(),
    };
  }
}
