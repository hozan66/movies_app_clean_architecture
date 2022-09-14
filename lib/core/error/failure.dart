import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // We need this failure message to display it to the user
  // either the message will be received from server or local storage
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure(super.message);
}
