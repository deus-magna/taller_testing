import 'package:dartz/dartz.dart';
import 'package:ravn_code_challenge/core/errors/failure.dart';
import 'package:ravn_code_challenge/data/models/people_response.dart';

// The one_member_abstracts linter is ignored because this project seeks to
// show a correct implementation of abstractions in a real project
// where a repository has multiple features.
// ignore: one_member_abstracts
abstract class PeopleRepository {
  Future<Either<Failure, PeopleResponse>> getPeople(String next);
}
