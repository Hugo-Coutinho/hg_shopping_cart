import 'package:flutter/material.dart';
import 'package:hg_shopping_cart/core/data/generate_token.dart';
import 'package:hg_shopping_cart/core/get_it/injection_container.dart';
import 'package:hg_shopping_cart/core/router/Router.dart';
import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/home/domain/usecase/home_use_case.dart';
import 'package:scoped_model/scoped_model.dart';
import 'core/logger/logger.dart';
import 'core/scoped_model/badge_scoped_model.dart';

final _mainLog = getLogger('main');

void main() async {
  _didApplicationLoad().whenComplete(() async {
    final myApp = locator<ShoppingCartApp>();
    runApp(myApp);
  });
}

Future<void> _didApplicationLoad() async {
  _mainLog.v('starting the application, doing the dependency injection and token generation');
  setupLocator();
  return await _setupRemoteApiAccess();
}

Future<void> _setupRemoteApiAccess() async {
  final GenerateToken generateToken = locator<GenerateToken>();
  return await generateToken.syncToken();
}

class ShoppingCartApp extends StatelessWidget {
  final Router router;

  ShoppingCartApp(this.router);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: locator<HomeUseCase>().getAllShoppingCartItems(),
      builder: (context, AsyncSnapshot<List<IconEntity>>snapshot) {
      return _buildMyApp(context, snapshot);
      },
    );
  }

  Widget _buildMyApp(BuildContext context, AsyncSnapshot<List<IconEntity>>snapshot) {
    _mainLog.d('Building the app by item requests');
    if (snapshot.connectionState == ConnectionState.done) {
      final itemsTotal = snapshot.data.map((item) => item.amount).fold(0,(current, next) => current + next);
      return _buildApp(context, itemsTotal);
    }
    return Container();
  }

  Widget _buildApp(BuildContext context, int amount) {
  final badge = BadgeScopedModel();
  badge.updateAmountFromLocalDatabase(amount);

  return GestureDetector(
      child: ScopedModel<BadgeScopedModel>(
        model: badge,
        child: _buildMaterialApp(),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
    );
  }

  Widget _buildMaterialApp() {
    return MaterialApp(
      title: Constant.appTitle,
      debugShowCheckedModeBanner: false,
      initialRoute: router.getInitialRoute(),
      routes: router.getRoutes(),
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
    );
  }
}

