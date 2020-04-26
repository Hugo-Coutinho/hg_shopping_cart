import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hg_shopping_cart/core/get_it/injection_container.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/presentation/bloc/shopping_cart_bloc.dart';

class ShoppingCartDefaultWidget extends StatefulWidget {
  @override
  _ShoppingCartDefaultWidgetState createState() => _ShoppingCartDefaultWidgetState();
}

class _ShoppingCartDefaultWidgetState extends State<ShoppingCartDefaultWidget> {
  final ShoppingCartBloc _bloc = locator<ShoppingCartBloc>();
  List<IconEntity> _shoppingList = List<IconEntity>();

  @override
  void initState() {
    _shoppingList = _bloc.getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return new ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: _shoppingList.length,
      itemBuilder: (context, i) {
        return _buildListViewForRow(i);
      },
    );
  }

  Widget _buildListViewForRow(int index) {
    final amountOfItem = _shoppingList[index].amount;

    return  new ListTile(
      leading: new IconButton(
        icon: Image.network(_shoppingList[index].url),
        onPressed: () {},
      ),
      title: new Text(_shoppingList[index].name),
      subtitle: new Text("amount: " + "$amountOfItem"),
      trailing: new IconButton(
        icon: new Icon(Icons.clear),
        onPressed: () {},
      ),
    );
  }

}
