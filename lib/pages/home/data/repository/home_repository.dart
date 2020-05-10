import 'package:dartz/dartz.dart';
import 'package:hg_shopping_cart/core/data/data_sources/icon_local_data_source.dart';
import 'package:hg_shopping_cart/core/data/data_sources/icon_remote_data_source.dart';
import 'package:hg_shopping_cart/core/error/exception.dart';
import 'package:hg_shopping_cart/core/error/failure.dart';
import 'package:hg_shopping_cart/core/network/network_info.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<IconModel>>> getIcons(int page);
  Future<Either<Failure, List<IconModel>>> retryGetIcons(int page);
  addItemToCart(IconModel item);
  Future<List<IconModel>> findAllFromLocalDataBase();
}

class HomeRepositoryImpl implements HomeRepository {
  final IconRemoteDataSource remoteDataSource;
  final IconLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl(this.remoteDataSource, this.localDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<IconModel>>> getIcons(int page) async => _getIconsFromRemote(remoteDataSource.getIcons(page));

  @override
  Future<Either<Failure, List<IconModel>>> retryGetIcons(int page) async => _getIconsFromRemote(remoteDataSource.retryGetIcons(page));

  @override
   addItemToCart(IconModel item) async {
   localDataSource.add([item]);
  }

  @override
  Future<List<IconModel>> findAllFromLocalDataBase() {
    return localDataSource.findAll();
  }

  Future<Either<Failure, List<IconModel>>> _getIconsFromRemote(Future<List<IconModel>> fetchingIcons) async {
    try {
      await networkInfo.connectionCheck();
      final serverResult = await fetchingIcons;
      return Right(serverResult);
    } on NetworkException {
      return Left(NetworkFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
 }
