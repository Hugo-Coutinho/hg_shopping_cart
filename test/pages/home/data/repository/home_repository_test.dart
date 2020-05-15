@TestOn('vm')

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hg_shopping_cart/core/data/data_sources/icon_local_data_source.dart';
import 'package:hg_shopping_cart/core/data/data_sources/icon_remote_data_source.dart';
import 'package:hg_shopping_cart/core/error/exception.dart';
import 'package:hg_shopping_cart/core/error/failure.dart';
import 'package:hg_shopping_cart/core/get_it/injection_container.dart';
import 'package:hg_shopping_cart/core/network/network_info.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import 'package:hg_shopping_cart/pages/home/data/repository/home_repository.dart';
import 'package:mockito/mockito.dart';
import '../../../../core/mock_http_client.dart';
import '../../../../core/mock_remote_data_source.dart';
import '../data_sources/icon_remote_data_source_test.dart';

class MockLocalDataSource extends Mock implements IconLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  IconRemoteDataSource _iconRemoteDataSource;
  MockLocalDataSource _mockLocalDataSource;
  MockNetworkInfo _mockNetworkInfo;
  HomeRepository _homeRepository;
  MockHttpClient _client;
  MockRemoteDataSource _mockHttpClient;
  MockGenerateToken _mockGenerateToken;

  setUp(() {
    _client = MockHttpClient();
    _mockHttpClient = MockRemoteDataSource(_client);
    _mockGenerateToken = MockGenerateToken();
    _iconRemoteDataSource = IconRemoteDataSourceImpl(_client, _mockGenerateToken);
    _mockLocalDataSource = MockLocalDataSource();
    _mockNetworkInfo = MockNetworkInfo();
    _homeRepository = HomeRepositoryImpl(_iconRemoteDataSource, _mockLocalDataSource, _mockNetworkInfo);
  });

  _networkOk() {
    when(_mockNetworkInfo.connectionCheck()).thenAnswer((_) async => Future.value());
  }

  _networkError() {
    when(_mockNetworkInfo.connectionCheck()).thenAnswer((_) async => throw NetworkException());
  }

    test(
      'Should get hundred icons',
      () async {
        // arrange
        _mockHttpClient.configureToMockToken();
        _mockHttpClient.setUpMockHttpClientSuccess200();
        _networkOk();

        try {
          // act
          final Either<Failure, List<IconModel>> eitherResult = await _homeRepository.getIcons(1);

          // assert
          eitherResult.fold(
              (failure) => expect(failure, throwsA(AssertionTestFailure)),
              (items)  {
                expect(items.length, equals(100));
              },
          );
        } on ServerException {
          throwsA(AssertionTestFailure);
        }
      },
    );

  test(
    'Should get hundred icons by retry',
        () async {

      // arrange
      setupLocator();
      _mockHttpClient.configureToMockToken();
      _mockHttpClient.setUpMockHttpClientSuccess200();
      _networkOk();

      try {
        // act
        final Either<Failure, List<IconModel>> eitherResult = await _homeRepository.retryGetIcons(1);

        // assert
        eitherResult.fold(
              (failure) => expect(failure, throwsA(AssertionTestFailure)),
              (items) {
            expect(items.length, equals(100));
          },
        );
      } on ServerException {
        throwsA(AssertionTestFailure);
      }
    },
  );

  test(
      'test network connection, should return network failure',
  () async {
    _mockHttpClient.configureToMockToken();
    _mockHttpClient.setUpMockHttpClientSuccess200();
    _networkError();

    expect(await _homeRepository.getIcons(1), Left(NetworkFailure()));

  });

  test('should bring items from local database',
      () async {
        final modelExpected = IconModel( url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Facebook', amount: 1);
      when(_mockLocalDataSource.findAll()).thenAnswer((_) => Future.value([modelExpected]));

      expect(await _homeRepository.findAllFromLocalDataBase(), [modelExpected]);
      }
  );
}
