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
    _getItemsBy8Pages();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream.stream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _buildGridView(snapshot.data);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildGridView(dynamic data) {
    return GridView.builder(
      itemCount: _getFilteredItems(data).length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 24.0, mainAxisSpacing: 32.0),
      itemBuilder: (BuildContext context, int index) {
        return Image.network(_getFilteredItems(data)[index].url);
      },
    );
  }

  List<IconEntity> _getFilteredItems(dynamic data) {
    // NAO CONSIGO USAR FUNCIONAL EM ITPOS DYNAMICS, E TB N CONSEGUI FAZER UM CASTING PARA O USO DO FUNCIONAL.
    // CORRIGIIIIIRRR!!!!!¸

//    return widget.filter.text.isNotEmpty ?
//    data.where((currentItem) => currentItem.name.toLowerCase().contains(widget.filter.text.toLowerCase())).toList()
//        : data;

  return widget.filter.text.isNotEmpty ? _doFilteredItems(data) : data;
  }

  List<IconEntity>_doFilteredItems (dynamic data) {
    List<IconEntity> listItem = List<IconEntity>();
    for (int i = 0; i < _getItemsFromDynamic(data).length; i++) {
      if (_getItemsFromDynamic(data)[i].name.toLowerCase().contains(widget.filter.text.toLowerCase())) {
        listItem.add(_getItemsFromDynamic(data)[i]);
      }
    }
    return listItem;
  }

  List<IconEntity> _getItemsFromDynamic(dynamic data) {
    List<IconEntity> listItem = List<IconEntity>();
    for (int i = 0; i < data.length; i++) {
      listItem.add(data[i]);
    }
    return listItem;
  }

  _getItemsBy8Pages() {
    final List<int> pages = [2, 3, 4, 5, 6, 7, 8];
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
    items.forEach((element) =>  _items.map((itemMapped) => itemMapped.name).toList().contains(element.name) ? "" : _items.add(element) );
  }
}

