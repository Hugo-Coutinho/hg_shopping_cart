import 'package:dartz/dartz.dart';
import 'package:hg_shopping_cart/core/data/data_sources/icon_local_data_source.dart';
import 'package:hg_shopping_cart/core/data/data_sources/icon_remote_data_source.dart';
import 'package:hg_shopping_cart/core/error/exception.dart';
import 'package:hg_shopping_cart/core/error/failure.dart';
import 'package:hg_shopping_cart/core/network/network_info.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<IconModel>>> getIcons(int page);
  Future<void> addItemToCart(IconModel item);
}

class HomeRepositoryImpl implements HomeRepository {
  final IconRemoteDataSource remoteDataSource;
  final IconLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl(this.remoteDataSource, this.localDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<IconModel>>> getIcons(int page) async {
    try {
      networkInfo.connectionCheck();
      final serverResult = await remoteDataSource.getIcons(page);
      return Right(serverResult);
    } on NetworkException {
      return Left(NetworkFailure());
    } on ServerException  {
      return Left(ServerFailure());
    }
  }

  @override
   addItemToCart(IconModel item) async {
   return await localDataSource.add([item]);
  }
}
