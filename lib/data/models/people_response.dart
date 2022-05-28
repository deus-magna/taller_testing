import 'dart:convert';

import 'package:equatable/equatable.dart';

PeopleResponse peopleResponseFromJson(String str) =>
    PeopleResponse.fromJson(json.decode(str));

class PeopleResponse extends Equatable {
  const PeopleResponse({
    required this.count,
    required this.next,
    required this.results,
  });

  factory PeopleResponse.fromJson(Map<String, dynamic> json) => PeopleResponse(
        count: json['count'],
        next: json['next'],
        results: List<People>.from(
          (json['results'] as List).map<People>(peopleFromJson),
        ),
      );

  final int count;
  final String next;
  final List<People> results;

  PeopleResponse copyWith({
    int? count,
    String? next,
    List<People>? results,
  }) {
    return PeopleResponse(
      count: count ?? this.count,
      next: next ?? this.next,
      results: results ?? this.results,
    );
  }

  @override
  List<Object?> get props => [
        count,
        next,
        results,
      ];
}

People peopleFromJson(dynamic json) => People.fromJson(json);

class People extends Equatable {
  const People(
      {required this.name,
      required this.height,
      required this.mass,
      required this.hairColor,
      required this.skinColor,
      required this.eyeColor,
      required this.birthYear,
      required this.homeworld,
      required this.films,
      required this.species,
      required this.vehicles,
      required this.starships,
      required this.created,
      required this.edited,
      required this.url,
      this.subheader,
      this.vehiclesList});

  factory People.fromJson(Map<String, dynamic> json) => People(
        name: json['name'],
        height: json['height'],
        mass: json['mass'],
        hairColor: json['hair_color'],
        skinColor: json['skin_color'],
        eyeColor: json['eye_color'],
        birthYear: json['birth_year'],
        homeworld: json['homeworld'],
        films: List<String>.from((json['films'] as List).map((x) => x)),
        species: List<String>.from((json['species'] as List).map((x) => x)),
        vehicles: List<String>.from((json['vehicles'] as List).map((x) => x)),
        starships: List<String>.from((json['starships'] as List).map((x) => x)),
        created: DateTime.parse(json['created']),
        edited: DateTime.parse(json['edited']),
        url: json['url'],
      );

  final String name;
  final String height;
  final String mass;
  final String hairColor;
  final String skinColor;
  final String eyeColor;
  final String birthYear;
  final String homeworld;
  final List<String> films;
  final List<String> species;
  final List<String> vehicles;
  final List<String> starships;
  final DateTime created;
  final DateTime edited;
  final String url;
  final String? subheader;
  final List<String>? vehiclesList;

  People copyWith({
    String? name,
    String? height,
    String? mass,
    String? hairColor,
    String? skinColor,
    String? eyeColor,
    String? birthYear,
    String? homeworld,
    List<String>? films,
    List<String>? species,
    List<String>? vehicles,
    List<String>? starships,
    DateTime? created,
    DateTime? edited,
    String? url,
    String? subheader,
    List<String>? vehiclesList,
  }) {
    return People(
      name: name ?? this.name,
      height: height ?? this.height,
      mass: mass ?? this.mass,
      hairColor: hairColor ?? this.hairColor,
      skinColor: skinColor ?? this.skinColor,
      eyeColor: eyeColor ?? this.eyeColor,
      birthYear: birthYear ?? this.birthYear,
      homeworld: homeworld ?? this.homeworld,
      films: films ?? this.films,
      species: species ?? this.species,
      vehicles: vehicles ?? this.vehicles,
      starships: starships ?? this.starships,
      created: created ?? this.created,
      edited: edited ?? this.edited,
      url: url ?? this.url,
      subheader: subheader,
      vehiclesList: vehiclesList,
    );
  }

  @override
  List<Object?> get props => [
        name,
        height,
        mass,
        hairColor,
        skinColor,
        eyeColor,
        birthYear,
        homeworld,
        films,
        species,
        vehicles,
        starships,
        created,
        edited,
        url,
        subheader,
        vehiclesList
      ];
}
