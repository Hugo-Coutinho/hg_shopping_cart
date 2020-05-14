import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:hg_shopping_cart/core/error/exception.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future connectionCheck();
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker _connectionChecker;

  NetworkInfoImpl(this._connectionChecker);

  @override
  Future<bool> get isConnected => _connectionChecker.hasConnection;

  @override
  Future connectionCheck() async {
    final connectionResult = await isConnected;
    connectionResult == true ? Future.value() : Future.value(throw NetworkException());

  }
}
