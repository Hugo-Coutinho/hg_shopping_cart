import 'package:hg_shopping_cart/core/data/data_sources/icon_remote_data_source.dart';
import 'package:hg_shopping_cart/core/data/generate_token.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import '../../../../core/mock_http_client.dart';
import '../../../../core/mock_remote_data_source.dart';

class MockGenerateToken extends Mock implements GenerateToken {}

main() {
  IconRemoteDataSource _dataSource;
  MockHttpClient _client;
  MockRemoteDataSource _mockRemoteDataSource;
  MockGenerateToken _mockGenerateToken;


  setUp(() {
    _client = MockHttpClient();
    _mockGenerateToken = MockGenerateToken();
    _mockRemoteDataSource = MockRemoteDataSource(_client);
    _dataSource = IconRemoteDataSourceImpl(_client, _mockGenerateToken);
  });

  test(
    'should return icons when the response code is 200 (success)',
        () async {
      // arrange
      _mockRemoteDataSource.configureToMockToken();
      _mockRemoteDataSource.setUpMockHttpClientSuccess200();

      try {
        // act
        final result = await _dataSource.getIcons(1);
        // assert
        expect(result.length, equals(100));
      } on Exception catch (e) {
        fail(e.toString());
      }
    },
  );

  test(
    'should return empty list when the response code is 404 or other',
        () {
      // arrange
          _mockRemoteDataSource.setUpMockHttpClientFailure404();

        // act
        //assert
        expect(_dataSource.getIcons(1), throwsException);
    },
  );

  test('Should retry connection with success',
        () async {
      _mockRemoteDataSource.configureToMockToken();
      when(_mockGenerateToken.syncToken()).thenAnswer((realInvocation) => Future.value());
      _mockRemoteDataSource.setUpMockHttpClientSuccess200();

      final result = await _dataSource.retryGetIcons(1);

      expect(result.length, equals(100));
    },
  );
}
