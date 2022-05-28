import 'package:flutter/material.dart';
import 'package:ravn_code_challenge/core/framework/colors.dart';
import 'package:ravn_code_challenge/data/models/people_response.dart';

class PersonCell extends StatelessWidget {
  const PersonCell({
    Key? key,
    required this.people,
    this.onPressed,
  }) : super(key: key);

  final People people;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(
        people.name,
        style: Theme.of(context).textTheme.headline2,
      ),
      subtitle: Text(
        people.subheader ?? '',
        style:
            Theme.of(context).textTheme.bodyText1!.copyWith(color: textLight),
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right,
        color: Colors.black,
      ),
    );
  }
}
