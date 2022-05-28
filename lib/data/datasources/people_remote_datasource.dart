import 'package:http/http.dart' as http;
import 'package:ravn_code_challenge/core/errors/exceptions.dart';
import 'package:ravn_code_challenge/data/models/people_response.dart';
import 'package:ravn_code_challenge/data/models/planet.dart';
import 'package:ravn_code_challenge/data/models/specie.dart';
import 'package:ravn_code_challenge/data/models/vehicle.dart';

abstract class PeopleRemoteDataSource {
  Future<PeopleResponse> getPeople(String url);
  Future<Planet> getPlanet(String url);
  Future<Specie> getSpecie(String url);
  Future<Vehicle> getVehicle(String url);
}

class PeopleRemoteDataSourceImpl extends PeopleRemoteDataSource {
  PeopleRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<PeopleResponse> getPeople(String url) async {
    final response = await _get(url);

    if (response.statusCode == 200) {
      return peopleResponseFromJson(response.body);
    } else {
      throw ServerException('Failed to Load Data', 'Error');
    }
  }

  @override
  Future<Planet> getPlanet(String url) async {
    final response = await _get(url);

    if (response.statusCode == 200) {
      return planetFromJson(response.body);
    } else {
      throw ServerException('Failed to Load Data', 'Error');
    }
  }

  @override
  Future<Specie> getSpecie(String url) async {
    final response = await _get(url);

    if (response.statusCode == 200) {
      return specieFromJson(response.body);
    } else {
      throw ServerException('Failed to Load Data', 'Error');
    }
  }

  @override
  Future<Vehicle> getVehicle(String url) async {
    final response = await _get(url);

    if (response.statusCode == 200) {
      return vehicleFromJson(response.body);
    } else {
      throw ServerException('Failed to Load Data', 'Error');
    }
  }

  Future<http.Response> _get(String url) async =>
      client.get(Uri.parse(url)).timeout(const Duration(seconds: 30));
}
