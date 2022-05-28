import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ravn_code_challenge/core/framework/colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(),
          const SizedBox(width: 8),
          Text(
            'Loading',
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: textLight),
          ),
        ],
      ),
    );
  }
}
