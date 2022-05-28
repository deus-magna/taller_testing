import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ravn_code_challenge/injection_container.dart' as di;
import 'package:ravn_code_challenge/injection_container.dart';
import 'package:ravn_code_challenge/presentation/bloc/people_cubit.dart';
import 'package:ravn_code_challenge/presentation/views/people_view.dart';

Future<void> main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          headline2: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
          bodyText1: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        appBarTheme: const AppBarTheme(color: Colors.black),
      ),
      title: 'Star Wars',
      home: BlocProvider(
        create: (context) => PeopleCubit(getPeopleFromServer: sl()),
        child: const PeopleView(),
      ),
    );
  }
}
