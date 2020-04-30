import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_shopping_cart/core/get_it/injection_container.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/core/util/widgets/loading.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/domain/usecase/shopping_cart_use_case.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/presentation/widgets/shopping_cart_Empty_widget.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/presentation/widgets/shopping_cart_default_widget.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCartPage> {
  final ShoppingCartUseCase _shoppingCartUseCase = locator<ShoppingCartUseCase>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _shoppingCartUseCase.getShoppingList(),
      builder: (context, AsyncSnapshot<List<IconEntity>>snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _presentLoading();
        }
        return _buildShoppingCartPage(snapshot.data);
      },
    );
  }

  Widget _buildShoppingCartPage(List<IconEntity> items) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constant.shoppingCartTitle),
      ),
      body: _buildBody(items),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBody(List<IconEntity> items) {
    return items.length > 0 ? ShoppingCartDefaultWidget(_shoppingCartUseCase) : _presentEmptyPage();
  }

  Widget _presentLoading() {
    return Loading();
  }

  Widget _presentEmptyPage() {
    return ShoppingCartEmptyWidget();
  }
}
