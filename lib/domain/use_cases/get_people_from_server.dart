import 'package:dartz/dartz.dart';
import 'package:ravn_code_challenge/core/errors/failure.dart';
import 'package:ravn_code_challenge/data/models/people_response.dart';
import 'package:ravn_code_challenge/domain/repositories/people_repository.dart';

class GetPeopleFromServer {
  GetPeopleFromServer(this.peopleRepository);

  final PeopleRepository peopleRepository;

  Future<Either<Failure, PeopleResponse>> call({required String next}) =>
      peopleRepository.getPeople(next);
}
