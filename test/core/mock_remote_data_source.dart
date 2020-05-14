import 'package:hg_shopping_cart/core/util/constant/constant.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../fixtures/get_icons.dart';
import 'mock_http_client.dart';

class MockRemoteDataSource {
  final MockHttpClient _client;

  MockRemoteDataSource(this._client);

  setUpMockHttpClientSuccess200() {
    when(_client.get(Uri.encodeFull(Constant.getIconsUrl + "1"),
        headers: {Constant.authorization: Constant.token}))
        .thenAnswer((_) async => http.Response(fixture('get_icons.json'), 200));
  }

  setUpMockHttpClientFailure404() {
    when(_client.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  configureToMockToken() {
    Constant.token = "mockToken";
  }
}