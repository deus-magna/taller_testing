import 'package:flutter/material.dart';
import 'package:ravn_code_challenge/data/models/people_response.dart';
import 'package:ravn_code_challenge/presentation/widgets/detail_cell.dart';
import 'package:ravn_code_challenge/presentation/widgets/section_header.dart';

class DetailsContainer extends StatelessWidget {
  const DetailsContainer({Key? key, required this.people}) : super(key: key);

  final People people;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: 'General Information'),
          DetailCell(label: 'Eye Color', value: people.eyeColor),
          DetailCell(label: 'Hair Color', value: people.hairColor),
          DetailCell(label: 'Skin Color', value: people.skinColor),
          DetailCell(label: 'Birth Year', value: people.birthYear),
          const SectionHeader(title: 'Vehicles'),
          ..._buildVehicles(people),
        ],
      );

  List<Widget> _buildVehicles(People people) {
    return people.vehiclesList!
        .map((vehicle) => DetailCell(label: vehicle))
        .toList();
  }
}
