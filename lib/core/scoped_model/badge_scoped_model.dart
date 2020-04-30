import 'package:scoped_model/scoped_model.dart';

class BadgeScopedModel extends Model {
  int _amount = 0;
  int get amount => _amount;

  incrementAmountShoppingItems() {
    _amount += 1;
    notifyListeners();
  }

  decrementAmountShoppingItems() {
    _amount -= 1;
    notifyListeners();
  }

  updateAmountFromLocalDatabase(int amount) {
    _amount = amount;
    notifyListeners();
  }
}