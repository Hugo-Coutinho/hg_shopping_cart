// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:hg_shopping_cart/main.dart';
import 'package:mockito/mockito.dart';

//class MockHttpClient extends Mock implements http.Client {}

void main() async {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {

//    final http.Client client = MockHttpClient();
//    final response = await client.get(
//        https: "api.themoviedb.org/3/tv/popular?api_key=8294d9700f85e20265086a49235ffbed"
//        headers: {
//          'Content-Type': 'application/json',
//          'Authorization': 'Bearer eyJ0eXAiOiAiSldUIiwgImFsZyI6ICJIUzI1NiJ9.eyJzdWIiOiAxMTEwLCAiZXhwIjogMTU4NjcyMDEwMCwgImlzcyI6ICJpY29uZmluZGVyLmNvbSIsICJpYXQiOiAxNTg2NzE5NTAwfQ==.cgpUo7QAbPfozzztmO1atjPy362VaZm397tn7FC1s2k='
//        }
//        );
//    final response = await client.get('https://api.themoviedb.org/3/tv/popular?api_key=8294d9700f85e20265086a49235ffbed');

//     Build our app and trigger a frame.

    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

