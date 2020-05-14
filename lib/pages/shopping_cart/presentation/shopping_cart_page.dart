import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_shopping_cart/core/scoped_model/badge_scoped_model.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/core/util/widgets/loading.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/domain/usecase/shopping_cart_use_case.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/presentation/widgets/shopping_cart_Empty_widget.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/presentation/widgets/shopping_cart_default_widget.dart';
import 'package:scoped_model/scoped_model.dart';

class ShoppingCartPage extends StatefulWidget {
  final ShoppingCartUseCase _shoppingCartUseCase;

  ShoppingCartPage(this._shoppingCartUseCase);

  @override
  _ShoppingCartState createState() => _ShoppingCartState(this._shoppingCartUseCase);
}

class _ShoppingCartState extends State<ShoppingCartPage> {
  final ShoppingCartUseCase _shoppingCartUseCase;

  _ShoppingCartState(this._shoppingCartUseCase);

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
        title: FittedBox(fit:BoxFit.fitWidth, child: Text(Constant.shoppingCartTitle)),
        actions: _buildClearAllAction(),
      ),
      body: _buildBody(items),
      resizeToAvoidBottomPadding: false,
    );
  }

  List<Widget> _buildClearAllAction() {
    return [
      SizedBox(width: 5,),
      _clearAllGestureRecognizer(),
    ];
  }

  Widget _clearAllGestureRecognizer() {
    return ScopedModelDescendant<BadgeScopedModel>(
        builder: (context, child, badge) {
          return GestureDetector(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.center,
              children: <Widget>[
                Icon(Icons.delete_forever),
                Text(Constant.clearAllButtonTitle),
                SizedBox(width: 5,),
              ],
            ),
            onTap: () {
              setState(() {
                _shoppingCartUseCase.clearAll();
                badge.updateAmountFromLocalDatabase(0);
              });
            },
          );
        }
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
