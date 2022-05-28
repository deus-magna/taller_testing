import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:ravn_code_challenge/core/errors/exceptions.dart';
import 'package:ravn_code_challenge/data/datasources/people_remote_datasource.dart';
import 'package:ravn_code_challenge/data/models/people_response.dart';
import 'package:ravn_code_challenge/data/models/planet.dart';

import '../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late PeopleRemoteDataSource dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = PeopleRemoteDataSourceImpl(client: mockClient);
  });

  void setUpMockHttpClientSuccess200(String tUrl, String json) {
    when(() => mockClient.get(
          Uri.parse(tUrl),
          headers: any(named: 'headers'),
        )).thenAnswer((_) async => http.Response(fixture(json), 200));
  }

  void setUpMockHttpClientError404(String tUrl) {
    when(() => mockClient.get(
          Uri.parse(tUrl),
          headers: any(named: 'headers'),
        )).thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getPeople:', () {
    // test('Should/Deberia - when/cuando')
    test('Deberia hacer un request de tipo GET', () async {
      const tUrl = 'https://swapi.dev/api/people';
      setUpMockHttpClientSuccess200(tUrl, 'people_response.json');

      await dataSource.getPeople(tUrl);
      verify(() => mockClient.get(Uri.parse(tUrl)));
    });

    test('Deberia regresar un PeopleResponse', () async {
      const tUrl = 'https://swapi.dev/api/people';
      final tPeopleResponse =
          peopleResponseFromJson(fixture('people_response.json'));

      setUpMockHttpClientSuccess200(tUrl, 'people_response.json');

      final result = await dataSource.getPeople(tUrl);
      expect(result, tPeopleResponse);
    });

    test('Deberia lanzar una exception cuando el codigo de respuesta es 404',
        () async {
      const tUrl = 'https://swapi.dev/api/people';

      setUpMockHttpClientError404(tUrl);
      final call = dataSource.getPeople(tUrl);
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getPlanet:', () {
    const tUrl = 'https://swapi.dev/api/planets/1';
    // test('Should/Deberia - when/cuando')
    test('Deberia hacer un request de tipo GET', () async {
      setUpMockHttpClientSuccess200(tUrl, 'planet_response.json');

      await dataSource.getPlanet(tUrl);
      verify(() => mockClient.get(Uri.parse(tUrl)));
    });

    test('Deberia regresar un PlanetResponse', () async {
      final tPlanet = planetFromJson(fixture('planet_response.json'));

      setUpMockHttpClientSuccess200(tUrl, 'planet_response.json');

      final result = await dataSource.getPlanet(tUrl);
      expect(result, tPlanet);
    });

    test('Deberia lanzar una exception cuando el codigo de respuesta es 404',
        () async {
      setUpMockHttpClientError404(tUrl);
      final call = dataSource.getPlanet(tUrl);
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
