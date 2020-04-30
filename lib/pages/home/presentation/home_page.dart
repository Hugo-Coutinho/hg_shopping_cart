import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hg_shopping_cart/core/get_it/injection_container.dart';
import 'package:hg_shopping_cart/core/scoped_model/badge_scoped_model.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_bloc.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_event.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_state.dart';
import 'package:hg_shopping_cart/pages/home/presentation/widgets/home_loaded_widget.dart';
import 'package:hg_shopping_cart/pages/home/presentation/widgets/home_loading_widget.dart';
import 'package:hg_shopping_cart/pages/home/presentation/widgets/home_with_error_widget.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _homeBloc = locator<HomeBloc>();
    final TextEditingController _filter = new TextEditingController();
  final BadgeScopedModel _badgeScopedModel = BadgeScopedModel();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text(Constant.appBarTitle);

  _HomePageState() {
    _filter.addListener(() { setState(() {} ); });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<BadgeScopedModel>(
      model: _badgeScopedModel,
      child: FutureBuilder(
        future: _homeBloc.getAmountShoppingCart(),
        builder: (context, AsyncSnapshot<List<IconEntity>>snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _presentHomePageWithBadge(snapshot.data);
          }
          return _presentHomePageDefault(_buildAppBarActions());
        },
      ),
    );
  }

  @override
  dispose() {
    _filter.dispose();
    super.dispose();
  }

  _presentHomePageWithBadge(List<IconEntity> items) {
    final itemsTotal = items.map((item) => item.amount).fold(0,(current, next) => current + next);
    _badgeScopedModel.updateAmountFromLocalDatabase(itemsTotal);

    return ScopedModel<BadgeScopedModel>(
      model: _badgeScopedModel,
      child: _presentHomePageDefault(_buildAppBarActionsWithBadge()),
    );
  }

  Widget _presentHomePageDefault(List<Widget> appBarActions) {
    return Scaffold(
      appBar: _buildBar(appBarActions),
      body: buildBody(context),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(List<Widget> actions) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
        actions: actions,
    );
  }

  List<Widget> _buildAppBarActions() {
    return [ _showCartIconIfIsNotSearching() ];
  }

  List<Widget> _buildAppBarActionsWithBadge() {
    return [
      Stack(
        children: <Widget>[
          _showCartIconIfIsNotSearching(),
          _showBadgeIfHasItem(),
        ],
      ),
    ];
  }

  Widget _showCartIconIfIsNotSearching() {
    return _searchIcon.icon == Icons.search ?  _cartIcon() : Container();
  }


  Widget _showBadgeIfHasItem() {
    return  ScopedModelDescendant<BadgeScopedModel>(
            builder: (context, child, badge) {
              return  badge.amount > 0 ? _badge(badge.amount) : Container();
            }
        );
  }

  Positioned _badge(int amount) {
    return new Positioned(
          right: 11,
          top: 11,
          child: new Container(
            padding: EdgeInsets.all(2),
            decoration: new BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(
              minWidth: 14,
              minHeight: 14,
            ),
            child: Text(
              '$amount',
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
  }

  IconButton _cartIcon() {
    return IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.of(context).pushNamed(Constant.shoppingCartPage);
          },
        );
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
      _searchIcon.icon == Icons.search ? _initSearch() : _stopSearch();
    });
  }

  _initSearch() {
    this._searchIcon = new Icon(Icons.close);
    this._appBarTitle = new TextField(
      controller: _filter,
      autofocus: true,
      decoration: new InputDecoration(hintText: 'Search...'),
    );
  }

  _stopSearch() {
    this._searchIcon = new Icon(Icons.search);
    this._appBarTitle = new Text(Constant.appBarTitle);
    _filter.clear();
  }
}
