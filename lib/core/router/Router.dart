import 'package:flutter/material.dart';
import 'package:hg_shopping_cart/core/get_it/injection_container.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/pages/home/presentation/home_page.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/presentation/shopping_cart_page.dart';

abstract class Router {
  String getInitialRoute();
  Map<String, Widget Function(BuildContext)> getRoutes();
}

class RouterImpl extends Router {

  @override
  String getInitialRoute() {
    return Constant.homePage;
  }

  Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      Constant.homePage: (context) => locator<HomePage>(),
      Constant.shoppingCartPage: (context) => locator<ShoppingCartPage>(),
    };
  }
}
