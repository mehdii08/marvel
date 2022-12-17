import 'package:equatable/equatable.dart';
import 'package:marvel_characters/core/errors/exceptions.dart';

class Failure extends Equatable {
  final String? message;
  final bool messageIsKey;

  const Failure._({required this.message, this.messageIsKey = false});

  factory Failure.fromException(Exception exception) {
    if (exception is NetworkException) {
      return const NetworkFailure();
    }
    if (exception is TimeoutException) {
      return const TimeoutFailure();
    }
    if (exception is ServerException) {
      return ServerFailure(
          message: exception.message, messageIsKey: exception.messageIsKey);
    }
    return const Failure._(message: 'errors.failed', messageIsKey: true);
  }

  @override
  List<Object?> get props => [message, messageIsKey];
}

class NetworkFailure extends Failure {
  const NetworkFailure()
      : super._(message: 'errors.network_error', messageIsKey: true);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure()
      : super._(message: 'errors.timeout_error', messageIsKey: true);
}

class ServerFailure extends Failure {
  const ServerFailure({required String? message, bool messageIsKey = false})
      : super._(message: message, messageIsKey: messageIsKey);
}
