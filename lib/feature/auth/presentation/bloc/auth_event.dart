abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  SignUpEvent(
      {required this.email,
      required this.password,
      required this.username,
      required this.gender,
      required this.dateOfBirth});

  final String email, password, username, gender, dateOfBirth;
}

// class SignInEven
