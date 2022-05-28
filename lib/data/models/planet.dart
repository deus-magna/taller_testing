import 'dart:convert';

import 'package:equatable/equatable.dart';

Planet planetFromJson(String str) => Planet.fromJson(json.decode(str));

class Planet extends Equatable {
  const Planet({
    required this.name,
  });

  factory Planet.fromJson(Map<String, dynamic> json) => Planet(
        name: json['name'],
      );

  final String name;

  @override
  List<Object?> get props => [name];
}
