import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ravn_code_challenge/core/errors/failure.dart';
import 'package:ravn_code_challenge/data/datasources/people_remote_datasource.dart';
import 'package:ravn_code_challenge/data/models/people_response.dart';
import 'package:ravn_code_challenge/data/models/planet.dart';
import 'package:ravn_code_challenge/data/models/specie.dart';
import 'package:ravn_code_challenge/data/models/vehicle.dart';
import 'package:ravn_code_challenge/data/repositories/people_repository_impl.dart';
import 'package:ravn_code_challenge/domain/repositories/people_repository.dart';

import '../../fixtures/fixture_reader.dart';

class MockRemoteDatasource extends Mock implements PeopleRemoteDataSource {}

void main() {
  late MockRemoteDatasource mockRemoteDatasource;
  late PeopleRepository peopleRepository;

  setUp(() {
    mockRemoteDatasource = MockRemoteDatasource();
    peopleRepository =
        PeopleRepositoryImpl(remoteDataSource: mockRemoteDatasource);
  });

  const tUrl = 'https://swapi.dev/api/people';

  test('getPeople', () async {
    final tPeopleResponse =
        peopleResponseFromJson(fixture('people_response.json'));
    final tPlanetResponse = planetFromJson(fixture('planet_response.json'));
    final tSpecieResponse = specieFromJson(fixture('specie_response.json'));
    final tVehicleResponse = vehicleFromJson(fixture('vehicle_response.json'));

    when(() => mockRemoteDatasource.getPeople(tUrl))
        .thenAnswer((_) async => tPeopleResponse);
    when(() => mockRemoteDatasource.getPlanet(any()))
        .thenAnswer((_) async => tPlanetResponse);
    when(() => mockRemoteDatasource.getSpecie(any()))
        .thenAnswer((_) async => tSpecieResponse);
    when(() => mockRemoteDatasource.getVehicle(any()))
        .thenAnswer((_) async => tVehicleResponse);

    final result = await peopleRepository.getPeople(tUrl);

    verify(() => mockRemoteDatasource.getPeople(tUrl));
    expect(result, equals(Right<Failure, PeopleResponse>(tPeopleResponse)));
  });
}
