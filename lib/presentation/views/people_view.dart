import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ravn_code_challenge/data/models/people_response.dart';
import 'package:ravn_code_challenge/presentation/bloc/people_cubit.dart';
import 'package:ravn_code_challenge/presentation/views/details_view.dart';
import 'package:ravn_code_challenge/presentation/widgets/details_container.dart';
import 'package:ravn_code_challenge/presentation/widgets/loading_indicator.dart';
import 'package:ravn_code_challenge/presentation/widgets/notice_cell.dart';
import 'package:ravn_code_challenge/presentation/widgets/person_cell.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PeopleView extends StatefulWidget {
  const PeopleView({Key? key}) : super(key: key);

  @override
  State<PeopleView> createState() => _PeopleViewState();
}

class _PeopleViewState extends State<PeopleView> {
  final _scrollController = ScrollController();
  People? _selectedPeople;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchData() {
    Future.delayed(const Duration(milliseconds: 250), () {
      if (context.read<PeopleCubit>().state is! PeopleLoading &&
          context.read<PeopleCubit>().state is! PeopleFirstLoading) {
        context.read<PeopleCubit>().loadPeopleListFromServer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => _buildMobile(),
      tablet: (BuildContext context) => _buildDesktop(),
      desktop: (BuildContext context) => _buildDesktop(),
    );
  }

  Widget _buildDesktop() => Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 17),
            child: Text('Ravn Star Wars Registry'),
          ),
          centerTitle: false,
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: _buildBloc(isDesktop: true),
            ),
            const VerticalDivider(width: 1),
            _selectedPeople != null
                ? SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      width: (MediaQuery.of(context).size.width * 0.75) - 1,
                      child: DetailsContainer(people: _selectedPeople!),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      );

  Widget _buildMobile() => Scaffold(
        appBar: AppBar(
          title: const Text('People of Star Wars'),
        ),
        body: _buildBloc(isDesktop: false),
      );

  Widget _buildBloc({required bool isDesktop}) =>
      BlocConsumer<PeopleCubit, PeopleState>(
        listener: (context, state) {
          if (state is PeopleLoading) {
            Future.delayed(const Duration(milliseconds: 300), () {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 250),
                curve: Curves.fastOutSlowIn,
              );
            });
          } else if (state is PeopleLoaded) {
            if (state.results.length == 10 &&
                MediaQuery.of(context).size.height > 760) {
              Future.delayed(const Duration(milliseconds: 250), () {
                context.read<PeopleCubit>().loadPeopleListFromServer();
              });
            }
          }
        },
        builder: (context, state) {
          if (state is PeopleInitial) {
            context.read<PeopleCubit>().loadPeopleListFromServer();
            return const LoadingIndicator();
          } else if (state is PeopleFirstLoading) {
            return const LoadingIndicator();
          } else if (state is PeopleLoading) {
            final results = state.results;
            return ListView.separated(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  if (index == results.length) {
                    return const LoadingIndicator();
                  }
                  return PersonCell(
                    people: results[index],
                    onPressed: () =>
                        _showDetailsView(results[index], isDesktop),
                  );
                },
                separatorBuilder: _buildDivider,
                itemCount: results.length + 1);
          } else if (state is PeopleLoaded) {
            final results = state.results;
            return ListView.separated(
                controller: _scrollController,
                itemBuilder: (context, index) => PersonCell(
                      people: results[index],
                      onPressed: () =>
                          _showDetailsView(results[index], isDesktop),
                    ),
                separatorBuilder: _buildDivider,
                itemCount: results.length);
          } else if (state is PeopleError) {
            return NoticeCell(message: state.message);
          } else {
            return const LoadingIndicator();
          }
        },
      );

  void _showDetailsView(People people, bool isDesktop) {
    if (isDesktop) {
      setState(() {
        _selectedPeople = people;
      });
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailsView(
          people: people,
        ),
      ));
    }
  }

  Widget _buildDivider(BuildContext context, int index) => const Divider(
        indent: 16,
        height: 0,
      );
}
