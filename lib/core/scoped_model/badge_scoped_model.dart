import 'package:scoped_model/scoped_model.dart';

class BadgeScopedModel extends Model {
  int _amount = 0;
  int get amount => _amount;

  void incrementAmountShoppingItems() {
    _amount += 1;
    notifyListeners();
  }

  void decrementAmountShoppingItems() {
    _amount -= 1;
    notifyListeners();
  }

  void updateAmountFromLocalDatabase(int currentAmount) {
    _amount = currentAmount;
    notifyListeners();
  }
}