import 'package:flutter_test/flutter_test.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/data/repository/shopping_cart_repository.dart';
import 'package:mockito/mockito.dart';

import '../../home/data/repository/home_repository_test.dart';

main() {
  MockLocalDataSource _mockLocalDataSource;
  ShoppingCartRepository _shoppingCartRepository;

  setUp(() {
    _mockLocalDataSource = MockLocalDataSource();
    _shoppingCartRepository = ShoppingCartRepositoryImpl(_mockLocalDataSource);
  });

  test('should return items from local database', () async {
    final item = IconModel(url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Facebook', amount: 1);
    when(_mockLocalDataSource.findAll()).thenAnswer((_) => Future.value([item]));

    expect(await _shoppingCartRepository.getShoppingList(), [item]);
  });
}
