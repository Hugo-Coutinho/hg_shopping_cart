import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:hg_shopping_cart/core/error/exception.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future connectionCheck();
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  Future connectionCheck() async {
    final connectionResult = await isConnected;
    connectionResult == true ? Future.value() : Future.value(throw NetworkException());

  }
}
