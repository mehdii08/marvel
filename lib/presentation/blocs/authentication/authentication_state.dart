import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationSucceed extends AuthenticationState {
  final String eTag;

  AuthenticationSucceed({required this.eTag});

  @override
  List<Object?> get props => [eTag];
}

class AuthenticationFailed extends AuthenticationState {
  final String failure;

  AuthenticationFailed({required this.failure});

  @override
  List<Object?> get props => [failure];
}
