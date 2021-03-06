import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hg_shopping_cart/core/scoped_model/badge_scoped_model.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/core/util/widgets/loading.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_bloc.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeLoadedWidget extends StatefulWidget {
  final TextEditingController filter;
  final HomeBloc homeBloc;

  HomeLoadedWidget(this.filter, this.homeBloc);

  @override
  _HomeLoadedWidgetState createState() => _HomeLoadedWidgetState();
}

class _HomeLoadedWidgetState extends State<HomeLoadedWidget> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<IconEntity>>(
      stream: widget.homeBloc.homeStreamOutput,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _buildGridView(context);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Loading();
      },
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      itemCount: widget.homeBloc.getFilteredItems(widget.filter).length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 16.0, mainAxisSpacing: 16.0),
      itemBuilder: (BuildContext context, int index) {
        return _buildGridViewItem(context, index);
      },
    );
  }

  Widget _buildGridViewItem(BuildContext context, int index) {
    final currentItem = widget.homeBloc.getFilteredItems(widget.filter)[index];

    return ScopedModelDescendant<BadgeScopedModel>(
        builder: (context, child, badge) {
          return IconButton(
            icon: Image.network(currentItem.url),
            onPressed: () {
              widget.homeBloc.addItem(currentItem);
              badge.incrementAmountShoppingItems();
              _alertUserItemWasSaved(context);
            },
          );
        }
    );
  }

  _alertUserItemWasSaved(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text(Constant.didSaveItemAlertTitle),
          content: new Text(Constant.didSaveItemAlertMessage),
          actions: <Widget>[
            CupertinoDialogAction(
                child: new Text("Ok"),
                onPressed: () {
                  Navigator.pop(context, 'Ok');
                }
            ),
          ],
        ),
    );
  }
}

