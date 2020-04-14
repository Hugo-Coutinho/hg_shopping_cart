import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import '../../../../fixtures/get_icons.dart';

void main() {
  test(
    'should be a subclass of Icon entity',
    () async {
      final iconModel = IconModel(url: '', name: '');
      // assert
      expect(iconModel, isA<IconEntity>());
    },
  );

  test('Should return an icon model when method fromJson were used', () {
    // arrange
    final modelExpected = IconModel(
        url: 'https://image.flaticon.com/icons/png/512/174/174848.png',
        name: 'Facebook');
    final Map<String, dynamic> jsonMap = json.decode(fixture('get_icons.json'))['data'][0];

    // act
    final result = IconModel.fromJson(jsonMap);

    // assert
    expect(modelExpected, result);
  });
}
