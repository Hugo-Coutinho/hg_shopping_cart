import 'package:flutter/material.dart';
import 'package:hg_shopping_cart/core/data/generate_token.dart';
import 'package:hg_shopping_cart/core/get_it/injection_container.dart';
import 'package:hg_shopping_cart/pages/home/presentation/HomePage.dart';

//void main() => runApp(MyApp());

void main() async {
  _didApplicationLoad();
}

Future<void> _didApplicationLoad() async {
  setupLocator();
  _setupRemoteApiAccess().whenComplete(() async {
    runApp(MyApp());
//    final IconLocalDataSource boxManager = locator<IconLocalDataSource>();
//    final HomeRepository homeRepository = locator<HomeRepository>();
//    final icons = await homeRepository.getIcons();

  });
}

Future<void> _setupRemoteApiAccess() async {
  final GenerateToken generateToken = locator<GenerateToken>();
  return await generateToken.syncToken();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
      home: HomePage(),
    );
  }
}