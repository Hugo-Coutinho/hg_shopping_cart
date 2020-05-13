import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hg_shopping_cart/core/get_it/injection_container.dart';
import 'package:hg_shopping_cart/core/scoped_model/badge_scoped_model.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_bloc.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_event.dart';
import 'package:hg_shopping_cart/pages/home/presentation/bloc/home_state.dart';
import 'package:hg_shopping_cart/pages/home/presentation/widgets/home_loaded_widget.dart';
import 'package:hg_shopping_cart/pages/home/presentation/widgets/home_loading_widget.dart';
import 'package:hg_shopping_cart/pages/home/presentation/widgets/home_network_connection_failure_widget.dart';
import 'package:hg_shopping_cart/pages/home/presentation/widgets/home_with_error_widget.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _homeBloc = locator<HomeBloc>();
  final TextEditingController _filter = new TextEditingController();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitleWidget = FittedBox(fit:BoxFit.fitWidth, child: Text(Constant.appBarTitle));
  Widget _appBarTitle = FittedBox(fit:BoxFit.fitWidth, child: Text(Constant.appBarTitle));


  _HomePageState() {
    _filter.addListener(() { setState(() {} ); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(),
      body: buildBody(context),
      resizeToAvoidBottomPadding: false,
    );
  }

  @override
  dispose() {
    _filter.dispose();
    super.dispose();
  }

  Widget _buildBar() {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
        actions: _buildAppBarActionsWithBadge(),
    );
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
    return ScopedModelDescendant<BadgeScopedModel>(
        builder: (context, child, badge) {
          return badge.amount > 0 ? _badge(badge.amount) : Container();
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
      create: (_) => _homeBloc..add(HomeDidLoadEvent()),
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

  Widget _mapWidgetByHomeCurrentState(HomeState state) {
    if (state is HomeLoadedState) {
      return HomeLoadedWidget(_filter, _homeBloc);
    } else if (state is HomeErrorState) {
      return HomeWithErrorWidget(state.message);
    } else if (state is HomeNetworkConnectionFailureState) {
      return HomeNetworkConnectionFailureWidget();
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
    this._appBarTitle = _appBarTitleWidget;
    _filter.clear();
  }
}
