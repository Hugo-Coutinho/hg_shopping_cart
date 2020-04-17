import 'package:flutter_test/flutter_test.dart';
import 'package:hg_shopping_cart/core/api/data_sources/icon_remote_data_source.dart';
import 'package:hg_shopping_cart/pages/home/data/model/icon_model.dart';
import '../../../../fixtures/get_icons.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  IconRemoteDataSource dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = IconRemoteDataSourceImpl(mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  test(
    'should return icons when the response code is 200 (success)',
        () {
      // arrange
      setUpMockHttpClientSuccess200();
      final modelExpected = IconModel(url: 'https://image.flaticon.com/icons/png/512/174/174848.png', name: 'Facebook',amount: 1);

      // act
      dataSource.getIcons().then((result) {
        // assert
        expect(modelExpected, result.first);
      });
    },
  );

  test(
    'should return empty list when the response code is 404 or other',
    () {
      // arrange
      setUpMockHttpClientFailure404();

      // act
      dataSource.getIcons().then((result) {
        // assert
        expect(0, result.asMap().length);
      });
    },
  );
}
