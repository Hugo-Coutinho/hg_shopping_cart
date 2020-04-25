import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hg_shopping_cart/core/get_it/injection_container.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
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
  final HomeBloc _homeBloc = locator<HomeBloc>();
  final TextEditingController _filter = new TextEditingController();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text(Constant.appBarTitle);

  _HomePageState() {
    _filter.addListener(() { setState(() {} ); });
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
        actions: _buildBarActions(),
    );
  }

  List<Widget> _buildBarActions() {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.of(context).pushNamed(Constant.shoppingCartPage);
        },
      )
    ];
  }

  BlocProvider<HomeBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => _homeBloc..add(HomeToListItemsEvent()),
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
      return HomeLoadedWidget(state.items, _filter, _homeBloc);
    } else if (state is HomeErrorState) {
      return HomeWithErrorWidget();
    }
    return HomeLoadingWidget();
  }

  _searchPressed() {
    setState(() {
      this._searchIcon.icon == Icons.search ? _initSearch() : _stopSearch();
    });
  }

  _initSearch() {
    this._searchIcon = new Icon(Icons.close);
    this._appBarTitle = new TextField(
      controller: _filter,
      autofocus: true,
      decoration: new InputDecoration(
          prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
    );
  }

  _stopSearch() {
    this._searchIcon = new Icon(Icons.search);
    this._appBarTitle = new Text(Constant.appBarTitle);
    _filter.clear();
  }
}
