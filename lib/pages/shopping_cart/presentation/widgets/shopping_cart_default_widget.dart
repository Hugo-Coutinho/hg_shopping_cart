import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hg_shopping_cart/core/scoped_model/badge_scoped_model.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/domain/usecase/shopping_cart_use_case.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/presentation/widgets/shopping_cart_Empty_widget.dart';
import 'package:scoped_model/scoped_model.dart';

class ShoppingCartDefaultWidget extends StatefulWidget {
  final ShoppingCartUseCase _shoppingCartUseCase;

  ShoppingCartDefaultWidget(this._shoppingCartUseCase);

  @override
  _ShoppingCartDefaultWidgetState createState() => _ShoppingCartDefaultWidgetState(_shoppingCartUseCase);
}

class _ShoppingCartDefaultWidgetState extends State<ShoppingCartDefaultWidget> {
  final ShoppingCartUseCase _shoppingCartUseCase;

  _ShoppingCartDefaultWidgetState(this._shoppingCartUseCase);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _shoppingCartUseCase.getShoppingList(),
      builder: (context, AsyncSnapshot<List<IconEntity>>snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        return  snapshot.data.length > 0 ? _buildBody(snapshot.data) : ShoppingCartEmptyWidget();
      },
    );
  }

  Widget _buildBody(List<IconEntity> items) {
    return new ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) {
        return _buildListViewForRow(i, items);
      },
    );
  }

  Widget _buildListViewForRow(int index, List<IconEntity> items) {
    final currentItem = items[index];
    final amountOfItem = currentItem.amount;

    return ScopedModelDescendant<BadgeScopedModel>(
        builder: (context, child, badge) {
          return ListTile(
            leading: IconButton(
              icon: Image.network(currentItem.url),
              onPressed: null,
            ),
            title: Text(currentItem.name),
            subtitle: Text("amount: " + "$amountOfItem"),
            trailing: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _shoppingCartUseCase.clearItem(currentItem);
                badge.decrementAmountShoppingItems();
                setState(() { });
              },
            ),
          );
        }
    );
  }
}
