import 'package:equatable/equatable.dart';
import 'package:ravn_code_challenge/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required this.code,
    required String message,
  }) : super(message: message);

  factory ServerFailure.fromException(ServerException exception) =>
      ServerFailure(
        message: exception.message,
        code: exception.code,
      );

  factory ServerFailure.general() =>
      const ServerFailure(code: 0, message: 'Failed to Load Data');

  final int code;
}
