import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';

class ShoppingCart extends StatefulWidget {



  @override
  _State createState() => _State();
}

class _State extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constant.shoppingCartTitle),
      ),
      body: buildBody(context),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget buildBody(BuildContext context) {
    return new ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: 4,
      itemBuilder: (context, i) {
        return _buildRow();
      },
    );
  }

  Widget _buildRow() {
    return new ListTile(
      leading: new IconButton(
        icon: new Icon(Icons.search),
        onPressed: () {},
      ),
    );
  }
}
