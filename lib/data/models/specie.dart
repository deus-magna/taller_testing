import 'dart:convert';

import 'package:equatable/equatable.dart';

Specie specieFromJson(String str) => Specie.fromJson(json.decode(str));

class Specie extends Equatable {
  const Specie({
    required this.name,
  });

  factory Specie.fromJson(Map<String, dynamic> json) => Specie(
        name: json['name'],
      );

  final String name;

  @override
  List<Object?> get props => [name];
}
