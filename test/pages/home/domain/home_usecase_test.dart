import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hg_shopping_cart/core/error/failure.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import 'package:hg_shopping_cart/pages/home/data/repository/home_repository.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/home/domain/usecase/home_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/get_icons.dart';

class MockHomeRepository extends Mock
    implements HomeRepository {}

void main() {
  HomeRepository repository;
  HomeUseCase usecase;

  setUp(() {
    repository = MockHomeRepository();
    usecase = HomeUseCaseImpl(repository);
  });

  List<IconEntity> _getIconsFromFixtures() {
    final Map<String, dynamic> jsonMap = json.decode(fixture('get_icons.json'));
    final jsonData =  List<dynamic>.from(jsonMap['data']);
    return jsonData.map((element) => IconModel.fromJson(element)).toList();
  }

  group('Testing either results from loadIcons() method', () {
    test(
      'Should bring hundred icon models',
          () async {
        // arrange

            final List<IconEntity> iconModelsFromJsonMap = _getIconsFromFixtures();
        when(repository.getIcons(1)).thenAnswer((_) async => Right(iconModelsFromJsonMap));

        // act
        final eitherResult = await usecase.loadIcons(1);

        // assert
        eitherResult.fold(
                (failure) => expect(throwsA(isAssertionError), iconModelsFromJsonMap),
                (items) => expect(items, iconModelsFromJsonMap)
        );
      },
    );

    test(
      'Should throw server failure',
          () async {
        // arrange
        when(repository.getIcons(1)).thenAnswer((_) async => Left(ServerFailure()));

        // act
        final eitherResult = await usecase.loadIcons(1);

        // assert
        eitherResult.fold(
                (failure) => expect(failure, ServerFailure()),
                (items) => expect(items, throwsA(isAssertionError))
        );
      },
    );
  });
}