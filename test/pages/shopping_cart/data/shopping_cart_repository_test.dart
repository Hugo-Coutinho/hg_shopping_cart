import 'package:flutter_test/flutter_test.dart';
import 'package:hg_shopping_cart/core/data/data_sources/icon_local_data_source.dart';
import 'package:hg_shopping_cart/core/get_it/injection_container.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import 'package:hg_shopping_cart/pages/shopping_cart/data/repository/shooping_cart_repository.dart';

void main() {
  ShoppingCartRepository repository;
  IconLocalDataSource boxManager;

  setUp(() {
    setupLocator();
     repository = locator<ShoppingCartRepository>();
     boxManager = locator<IconLocalDataSource>();

  });

  tearDown(() {
  boxManager.tearDown();
  boxManager.deleteAll();
  });

  Future<List<IconModel>> _mockItems() {
    return Future.value([
    IconModel(url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Facebook',amount: 1),
    IconModel(url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Facebook',amount: 1),
    IconModel(url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Facebook',amount: 1)
    ]);
  }

  _preparingLocalStorage() {
    final item = IconModel(url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Facebook',amount: 1);
    final item2 = IconModel(url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Facebook',amount: 1);
    final item3 = IconModel(url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Facebook',amount: 1);
    boxManager.add([item, item2, item3]);
  }

  test(
    'Should bring all icons from local storage.',
        () async {
      // arrange
            _preparingLocalStorage();

            // act
            final result = await repository.findAllShoppingCart();

            // assert
            expect(_mockItems(), result);
    },
  );

  test(
    'Should decrement item amount.',
        () async {
      // arrange
        _preparingLocalStorage();
        final item = IconModel(url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Facebook',amount: 1);

        // act
        await repository.clearItem(item);
        final items = await repository.findAllShoppingCart();


        // assert
        expect(2, items.first.amount);
    },
  );
}