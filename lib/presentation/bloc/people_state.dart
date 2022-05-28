part of 'people_cubit.dart';

abstract class PeopleState extends Equatable {
  const PeopleState();

  @override
  List<Object> get props => [];
}

class PeopleInitial extends PeopleState {}

class PeopleFirstLoading extends PeopleState {}

class PeopleLoading extends PeopleState {
  const PeopleLoading({required this.results});

  final List<People> results;

  @override
  List<Object> get props => [results];
}

class PeopleError extends PeopleState {
  const PeopleError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class PeopleLoaded extends PeopleState {
  const PeopleLoaded({required this.results});

  final List<People> results;

  @override
  List<Object> get props => [results];
}
