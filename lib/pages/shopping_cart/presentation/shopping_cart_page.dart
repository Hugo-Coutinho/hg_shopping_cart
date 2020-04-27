import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hg_shopping_cart/core/get_it/injection_container.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/presentation/bloc/shopping_cart_bloc.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/presentation/widgets/shopping_cart_default_widget.dart';
import 'bloc/shopping_cart_event.dart';
import 'bloc/shopping_cart_state.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ShoppingCartPage> {
  final ShoppingCartBloc _bloc = locator<ShoppingCartBloc>();

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

  BlocProvider<ShoppingCartBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc..add(ShoppingCartDefaultEvent()),
      child: Center(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
              builder: (context, state) {
                return _mapWidgetByShoppingCartCurrentState(state);
              },
            )),
      ),
    );
  }

  _mapWidgetByShoppingCartCurrentState(ShoppingCartState state) {
    if (state is ShoppingCartDefaultState) {
      return ShoppingCartDefaultWidget();
    }
  }
}
