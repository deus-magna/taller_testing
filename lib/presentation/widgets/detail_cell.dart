import 'package:flutter/material.dart';
import 'package:ravn_code_challenge/core/extensions/string_extension.dart';
import 'package:ravn_code_challenge/core/framework/colors.dart';

/// Figma conventions are renamed,
/// because the framework already has a widget called DataCell.
class DetailCell extends StatelessWidget {
  const DetailCell({
    Key? key,
    this.value,
    required this.label,
  }) : super(key: key);

  final String? value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 15, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: textLight),
              ),
              value == null
                  ? const SizedBox.shrink()
                  : Text(
                      value!.capitalize(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(indent: 16, height: 1),
        ],
      ),
    );
  }
}
