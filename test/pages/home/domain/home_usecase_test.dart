import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hg_shopping_cart/core/error/exception.dart';
import 'package:hg_shopping_cart/core/error/failure.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import 'package:hg_shopping_cart/pages/home/data/model/serialization/icon_model_serialization/icon_model_serializable.dart';
import 'package:hg_shopping_cart/pages/home/data/repository/home_repository.dart';
import 'package:hg_shopping_cart/pages/home/domain/entity/icon_entity.dart';
import 'package:hg_shopping_cart/pages/home/domain/usecase/home_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../../fixtures/get_icons.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  HomeRepository _homeRepository;
  HomeUseCase _homeUseCase;

  setUp(() {
    _homeRepository = MockHomeRepository();
    _homeUseCase = HomeUseCaseImpl(_homeRepository);
  });

  List<IconEntity> _getIconsFromFixtures() {
    final Map<String, dynamic> jsonMap = json.decode(fixture('get_icons.json'));
    final jsonData =  List<dynamic>.from(jsonMap['data']);
    return jsonData.map((element) => IconModelSerializable.fromJson(element)).toList();
  }

  group('Testing either results from loadIcons() method', () {
    test(
      'Should bring hundred icon models',
          () async {
        // arrange

            final List<IconEntity> iconModelsFromJsonMap = _getIconsFromFixtures();
        when(_homeRepository.getIcons(1)).thenAnswer((_) async => Right(iconModelsFromJsonMap));

        // act
        final eitherResult = await _homeUseCase.loadIcons(1);

        // assert
        eitherResult.fold(
                (failure) => expect(throwsA(AssertionTestFailure), iconModelsFromJsonMap),
                (items) => expect(items, iconModelsFromJsonMap)
        );
      },
    );

    test(
      'Should throw server failure',
          () async {
        // arrange
        when(_homeRepository.getIcons(1)).thenAnswer((_) async => Left(ServerFailure()));

        // act
        final eitherResult = await _homeUseCase.loadIcons(1);

        // assert
        eitherResult.fold(
                (failure) => expect(failure, ServerFailure()),
                (items) => expect(items, throwsA(AssertionTestFailure))
        );
      },
    );
  });

  test('should return items filtered by string',
      () {
        final predicate = "zap";
        final faceItem = IconModel( url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Facebook', amount: 1);
        final socialItem = IconModel( url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Instagram', amount: 1);
        final zapItem = IconModel( url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Zapzap', amount: 1);
        final items = [faceItem, socialItem, zapItem];
        final itemsExpected = [zapItem];

         expect(_homeUseCase.getFilteredItems(predicate, items), itemsExpected);
      },
  );

  test('should return items from local database',
      () async {
        final modelExpected = IconModel( url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Facebook', amount: 1);
        when(_homeRepository.findAllFromLocalDataBase()).thenAnswer((_) => Future.value([modelExpected]));

        expect(await _homeUseCase.getAllShoppingCartItems(), [modelExpected]);
      }
  );

  test('Should retry connection with success',
        () {
    final Future<Either<Failure, List<IconModel>>> answer = Future.value(Right([IconModel( url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Facebook', amount: 1)]));
      when(_homeRepository.retryGetIcons(1)).thenAnswer((_) => answer);

      expect(_homeUseCase.retryLoadIcons(1), equals(answer));
    },
  );
}