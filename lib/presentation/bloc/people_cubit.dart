import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ravn_code_challenge/data/models/people_response.dart';
import 'package:ravn_code_challenge/domain/use_cases/get_people_from_server.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit({required this.getPeopleFromServer}) : super(PeopleInitial());

  List<People> people = [];
  String next = 'https://swapi.dev/api/people';

  final GetPeopleFromServer getPeopleFromServer;

  Future<void> loadPeopleListFromServer() async {
    if (people.isEmpty) {
      emit(PeopleFirstLoading());
    } else {
      emit(PeopleLoading(results: people));
    }
    final peopleOrFailure = await getPeopleFromServer(next: next);

    peopleOrFailure.fold((failure) {
      people = [];
      next = 'https://swapi.dev/api/people';
      emit(PeopleError(failure.message));
    }, (peopleResult) {
      people.addAll(peopleResult.results);
      next = peopleResult.next;
      emit(PeopleLoaded(results: people));
    });
  }
}
