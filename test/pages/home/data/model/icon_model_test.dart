import 'dart:convert';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import 'package:hg_shopping_cart/pages/home/data/model/serialization/icon_model_serialization/icon_model_serializable.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:test/test.dart';
import '../../../../fixtures/get_icons.dart';

void main() {
  test(
    'should be a subclass of Icon entity',
    () async {
      final iconModel = IconModel(url: '', name: '', amount: 1);
      // assert
      expect(iconModel, isA<IconEntity>());
    },
  );

  test('Should return an icon model when method fromJson were used', () {
    // arrange
    final modelExpected = IconModel( url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Facebook', amount: 1);
    final Map<String, dynamic> jsonMap = json.decode(fixture('get_icons.json'))['data'][0];

    // act
    final result = IconModelSerializable.fromJson(jsonMap);

    // assert
    expect(modelExpected.name, result.name);
    expect(modelExpected.url, result.url);
    expect(modelExpected.amount, result.amount);
  });
}
