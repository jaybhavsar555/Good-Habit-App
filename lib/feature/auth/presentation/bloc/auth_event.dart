import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {}

class SignUpEvent extends AuthEvent {
  SignUpEvent(
      {required this.email,
      required this.password,
      required this.username,
      required this.gender,
      required this.dateOfBirth});

  final String email, password, username, gender, dateOfBirth;

  @override
  List<Object?> get props => [username, email, password, gender, dateOfBirth];
}

class SignInEvent extends AuthEvent {
  SignInEvent({required this.email, required this.password});

  final String email, password;

  @override
  List<Object?> get props => [email, password];
}

class SignOutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
