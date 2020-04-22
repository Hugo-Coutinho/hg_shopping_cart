import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hg_shopping_cart/core/data/data_sources/icon_local_data_source.dart';
import 'package:hg_shopping_cart/core/data/data_sources/icon_remote_data_source.dart';
import 'package:hg_shopping_cart/core/error/exception.dart';
import 'package:hg_shopping_cart/core/error/failure.dart';
import 'package:hg_shopping_cart/core/network/network_info.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import 'package:hg_shopping_cart/pages/home/data/repository/home_repository.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/get_icons.dart';

class MockRemoteDataSource extends Mock implements IconRemoteDataSource {}

class MockLocalDataSource extends Mock implements IconLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;
  HomeRepository homeRepository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    homeRepository = HomeRepositoryImpl(
        mockRemoteDataSource, mockLocalDataSource, mockNetworkInfo);
  });

  List<IconEntity> _getIconsFromFixtures() {
    final Map<String, dynamic> jsonMap = json.decode(fixture('get_icons.json'));
    final jsonData = List<dynamic>.from(jsonMap['data']);
    return jsonData.map((element) => IconModel.fromJson(element)).toList();
  }

  group('Testing either results from getIcons() method', () {
    test(
      'Should get hundred icons',
          () async {

        // arrange
        final List<IconModel> iconModelsFromJsonMap = _getIconsFromFixtures();
        when(mockRemoteDataSource.getIcons()).thenAnswer((_) async => iconModelsFromJsonMap);

        try {
          // act
          final Either<Failure, List<IconModel>> eitherResult = await homeRepository.getIcons();

          // assert
          eitherResult.fold((failure) => expect(failure, throwsA(isAssertionError)),
                  (items) => expect(items, iconModelsFromJsonMap));

        } on ServerException {
          throwsA(isAssertionError);
        }
      },
    );

    test(
      'Should throw Service Failure',
          () async {

        // arrange
        when(mockRemoteDataSource.getIcons()).thenAnswer((_) async => throw ServerException());

        try {
          // act
          await homeRepository.getIcons();

          // assert
          throwsA(isAssertionError);
        } on Exception catch (e) {
          expect(e, ServerException);
        }
      },
    );
  });

  group('Testing either results from didFilterIconsByName(String name) method', () {

    test(
      'Should throw Service Failure',
          () async {

        // arrange
            final iconName = "apple";
        when(mockRemoteDataSource.getIcons()).thenAnswer((_) async => throw ServerException());

        try {
          // act
          await homeRepository.didFilterIconsByName(iconName);

          // assert
          throwsA(isAssertionError);

        } on Exception catch (e) {
          expect(e, ServerException);
        }
      },
    );
  });
}
