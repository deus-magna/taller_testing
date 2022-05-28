import 'dart:convert';

import 'package:equatable/equatable.dart';

Vehicle vehicleFromJson(String str) => Vehicle.fromJson(json.decode(str));

class Vehicle extends Equatable {
  const Vehicle({
    required this.name,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        name: json['name'],
      );

  final String name;

  @override
  List<Object?> get props => [name];
}
