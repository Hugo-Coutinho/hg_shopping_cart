import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hg_shopping_cart/core/get_it/injection_container.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_bloc.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_event.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_state.dart';
import 'package:hg_shopping_cart/pages/home/presentation/widgets/home_loaded_widget.dart';
import 'package:hg_shopping_cart/pages/home/presentation/widgets/home_loading_widget.dart';
import 'package:hg_shopping_cart/pages/home/presentation/widgets/home_with_error_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _filter = new TextEditingController();
  List names = new List();
  String _searchText = "";
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search an food');

  _HomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: buildBody(context),
      resizeToAvoidBottomPadding: false,
    );
  }

  @override
  void dispose() {
    _filter.dispose();
    super.dispose();
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  BlocProvider<HomeBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<HomeBloc>()..add(HomeToListItemsEvent()),
      child: Center(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return _mapWidgetByHomeCurrentState(state);
              },
            )),
      ),
    );
  }

  _mapWidgetByHomeCurrentState(HomeState state) {
    if (state is HomeLoadedState) {
      return HomeLoadedWidget(state.items, _filter);
    } else if (state is HomeErrorState) {
      return HomeWithErrorWidget();
    }
    return HomeLoadingWidget();
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          autofocus: true,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search a food');
        filteredNames = names;
        _filter.clear();
      }
    });
  }
}
