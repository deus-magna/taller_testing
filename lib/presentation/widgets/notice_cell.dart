import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ravn_code_challenge/core/framework/colors.dart';
import 'package:ravn_code_challenge/presentation/bloc/people_cubit.dart';

class NoticeCell extends StatelessWidget {
  const NoticeCell({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(milliseconds: 500), () {
          context.read<PeopleCubit>().loadPeopleListFromServer();
        });
      },
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.topCenter,
            child: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: textEmphasis),
            ),
          ),
        ],
      ),
    );
  }
}
