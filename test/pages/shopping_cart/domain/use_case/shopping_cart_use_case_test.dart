import 'package:flutter_test/flutter_test.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/data/repository/shopping_cart_repository.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/domain/usecase/shopping_cart_use_case.dart';
import 'package:mockito/mockito.dart';

class MockShoppingCartRepository extends Mock implements ShoppingCartRepository {}

main () {
MockShoppingCartRepository _shoppingCartRepository;
ShoppingCartUseCase _shoppingCartUseCase;

setUp(() {
  _shoppingCartRepository = MockShoppingCartRepository();
      _shoppingCartUseCase = ShoppingCartUseCaseImpl(_shoppingCartRepository);
});

test('should get the shopping list from the local database',
    () {
      final item = IconModel(url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Facebook', amount: 1);
      final Future<List<IconModel>> resultExpected = Future.value([item]);
     when(_shoppingCartRepository.getShoppingList()).thenAnswer((_) => resultExpected);

     expect(_shoppingCartUseCase.getShoppingList(), resultExpected);
    },
);

}