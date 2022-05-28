import 'package:flutter/material.dart';
import 'package:ravn_code_challenge/data/models/people_response.dart';
import 'package:ravn_code_challenge/presentation/widgets/details_container.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({Key? key, required this.people}) : super(key: key);

  final People people;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(people.name),
      ),
      body: SingleChildScrollView(child: DetailsContainer(people: people)),
    );
  }
}
