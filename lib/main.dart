import 'package:flutter/material.dart';
import 'package:hg_shopping_cart/core/data/generate_token.dart';
import 'package:hg_shopping_cart/core/get_it/injection_container.dart';
import 'package:hg_shopping_cart/core/router/Router.dart';

void main() async {
  _didApplicationLoad().whenComplete(() async {
    runApp(MyApp());
  });
}

Future<void> _didApplicationLoad() async {
  setupLocator();
  return await _setupRemoteApiAccess();
}

Future<void> _setupRemoteApiAccess() async {
  final GenerateToken generateToken = locator<GenerateToken>();
  return await generateToken.syncToken();
}

class MyApp extends StatelessWidget {
  final router = Router();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        title: 'Shopping cart',
        initialRoute: router.getInitialRoute(),
        routes: router.getRoutes(),
        theme: ThemeData(
          primaryColor: Colors.green.shade800,
          accentColor: Colors.green.shade600,
        ),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
    );
  }
}

