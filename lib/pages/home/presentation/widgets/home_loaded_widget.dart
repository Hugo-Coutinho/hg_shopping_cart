import 'package:flutter/material.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_bloc.dart';

class HomeLoadedWidget extends StatefulWidget {

  final List<IconEntity> items;
  final TextEditingController filter;
  final HomeBloc homeBloc;

  HomeLoadedWidget(this.items, this.filter, this.homeBloc);

  @override
  _HomeLoadedWidgetState createState() => _HomeLoadedWidgetState();
}

class _HomeLoadedWidgetState extends State<HomeLoadedWidget> {


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _getFilteredItems().length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 24.0, mainAxisSpacing: 32.0),
      itemBuilder: (BuildContext context, int index) {
        return Image.network(_getFilteredItems()[index].url);
      },
    );
  }

  List<IconEntity> _getFilteredItems() {
    if (widget.filter.text.isNotEmpty) {
      return widget.items.where((currentItem) => currentItem.name.toLowerCase().contains(widget.filter.text.toLowerCase())).toList();
    }
    return widget.items;
  }
}

