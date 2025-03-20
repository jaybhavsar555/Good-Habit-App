import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<void> call(
    String email,
    String password,
    String username,
    String gender,
    String dateOfBirth,
  ) {
    return repository.signUp(email, password, username, gender, dateOfBirth);
  }
}
