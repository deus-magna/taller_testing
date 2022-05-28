import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ravn_code_challenge/core/errors/exceptions.dart';
import 'package:ravn_code_challenge/core/errors/failure.dart';
import 'package:ravn_code_challenge/data/datasources/people_remote_datasource.dart';
import 'package:ravn_code_challenge/data/models/people_response.dart';
import 'package:ravn_code_challenge/data/models/specie.dart';
import 'package:ravn_code_challenge/domain/repositories/people_repository.dart';

class PeopleRepositoryImpl implements PeopleRepository {
  PeopleRepositoryImpl({
    required this.remoteDataSource,
  });

  final PeopleRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, PeopleResponse>> getPeople(String next) async {
    try {
      final peopleResponse = await remoteDataSource.getPeople(next);
      final people = await _getExtraValues(peopleResponse);
      final results = peopleResponse.copyWith(results: people);
      return Right(results);
    } on ServerException catch (_) {
      return Left(ServerFailure.general());
    } on TimeoutException catch (_) {
      return Left(ServerFailure.general());
    } on SocketException catch (_) {
      return Left(ServerFailure.general());
    }
  }

  Future<List<People>> _getExtraValues(PeopleResponse peopleResponse) async {
    final peopleList = peopleResponse.results;
    return Future.wait(peopleList.map((people) async {
      final subheader =
          await _getPlanetAndSpecie(people.homeworld, people.species);
      final vehicles = await _getVehicles(people.vehicles);
      return people.copyWith(subheader: subheader, vehiclesList: vehicles);
    }).toList());
  }

  // Human is used as the default specie since the API doesn't enter humans
  // in the species list even though the Figma UI includes it.
  Future<String> _getPlanetAndSpecie(
      String homeworldUrl, List<String> species) async {
    final homeworld = await remoteDataSource.getPlanet(homeworldUrl);
    final specie = species.isEmpty
        ? const Specie(name: 'Human')
        : await remoteDataSource.getSpecie(species.first);

    return '${specie.name} from ${homeworld.name}';
  }

  Future<List<String>> _getVehicles(List<String> vehiclesList) async {
    final vehicles = <String>[];
    for (final url in vehiclesList) {
      final vehicle = await remoteDataSource.getVehicle(url);
      vehicles.add(vehicle.name);
    }
    return vehicles;
  }
}
