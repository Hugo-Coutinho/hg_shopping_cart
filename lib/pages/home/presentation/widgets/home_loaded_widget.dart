import 'dart:async';

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

  List<IconEntity> _items;
  StreamController _stream = StreamController<List<IconEntity>>();

  @override
  void initState() {
    _items = widget.items;
    _stream.add(_items);
    _getThousandItems();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream.stream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _buildGridView();
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      itemCount: _getFilteredItems().length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 24.0, mainAxisSpacing: 32.0),
      itemBuilder: (BuildContext context, int index) {
        return _buildGridViewItem(index);
      },
    );
  }

  Widget _buildGridViewItem(int index) {
    final currentItem = _getFilteredItems()[index];

    return GestureDetector(
      child: Image.network(currentItem.url),
      onTap: () {
        widget.homeBloc.addItem(currentItem);
      },
    );
  }

  List<IconEntity> _getFilteredItems() {
    return widget.filter.text.isNotEmpty ?
    _items.where((currentItem) => currentItem.name.toLowerCase().contains(widget.filter.text.toLowerCase())).toList()
        : _items;
  }


  _getThousandItems() {
    final List<int> pages = [2, 3, 4, 5, 6, 7, 8, 9, 10];
    pages.forEach((currentPage) { _fetchItemsByPage(currentPage); });
  }

  _fetchItemsByPage(int page) async {
    final fetchItems = await widget.homeBloc.fetchingItems(page);
    setState(() {
      print("inside setstate");
      fetchItems.fold(
            (failure) => failure,
            (items) => _addItemsToList(items),
      );
      _stream.add(_items);
    });
  }

  _addItemsToList(List<IconEntity> items) {
    items.forEach((element) =>  _items.map((itemMapped) => itemMapped.name.toLowerCase()).toList().contains(element.name.toLowerCase()) ? "" : _items.add(element) );
  }
}

