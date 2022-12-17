import 'package:equatable/equatable.dart';

class AppException extends Equatable implements Exception {
  final String? message;
  final bool messageIsKey;

  const AppException({this.message, this.messageIsKey = false});

  @override
  List<Object?> get props => [message];
}

class NetworkException extends AppException {
  const NetworkException()
      : super(message: 'errors.network_error', messageIsKey: true);
}

class TimeoutException extends AppException {
  const TimeoutException()
      : super(message: 'errors.timeout_error', messageIsKey: true);
}

class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
    required this.statusCode,
    required super.message,
  });
}
