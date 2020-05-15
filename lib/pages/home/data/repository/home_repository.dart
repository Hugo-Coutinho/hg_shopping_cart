import 'package:dartz/dartz.dart';
import 'package:hg_shopping_cart/core/data/data_sources/icon_local_data_source.dart';
import 'package:hg_shopping_cart/core/data/data_sources/icon_remote_data_source.dart';
import 'package:hg_shopping_cart/core/error/exception.dart';
import 'package:hg_shopping_cart/core/error/failure.dart';
import 'package:hg_shopping_cart/core/logger/logger.dart';
import 'package:hg_shopping_cart/core/network/network_info.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<IconModel>>> getIcons(int page);
  Future<Either<Failure, List<IconModel>>> retryGetIcons(int page);
  addItemToCart(IconModel item);
  Future<List<IconModel>> findAllFromLocalDataBase();
  disposeLocalStorage();
}

class HomeRepositoryImpl implements HomeRepository {
  final IconRemoteDataSource _remoteDataSource;
  final IconLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  final _log = getLogger('home_repository');

  HomeRepositoryImpl(this._remoteDataSource, this._localDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<IconModel>>> getIcons(int page) async => _getIconsFromRemote(_remoteDataSource.getIcons(page));

  @override
  Future<Either<Failure, List<IconModel>>> retryGetIcons(int page) async => _getIconsFromRemote(_remoteDataSource.retryGetIcons(page));

  @override
  addItemToCart(IconModel item) async {
    _log.i('calling local data source to put a new item to the cart');
    _localDataSource.add([item]);
  }

  @override
  Future<List<IconModel>> findAllFromLocalDataBase() {
    _log.i('getting all items from local');
    return _localDataSource.findAll();
  }

  @override
  disposeLocalStorage() {
    _log.i('calling Hive to shutdown it');
    _localDataSource.tearDown();
  }

  Future<Either<Failure, List<IconModel>>> _getIconsFromRemote(Future<List<IconModel>> fetchingIcons) async {
    _log.w('getting items from remote');
    try {
      await _networkInfo.connectionCheck();
      final serverResult = await fetchingIcons;
      return Right(serverResult);
    } on NetworkException {
      _log.e('phone with bad network connection');
      return Left(NetworkFailure());
    } on ServerException {
      _log.e('something bad happened with icons request');
      return Left(ServerFailure());
    }
  }
 }
