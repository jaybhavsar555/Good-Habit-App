import 'package:good_habit_app/feature/auth/domain/entities/user_entity.dart';

import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase(this.authRepository);

  Future<UserEntity> execute(
    String email,
    String password,
    String username,
    String gender,
    String dateOfBirth,
  ) {
    return authRepository.signUp(
        email, password, username, gender, dateOfBirth);
  }
}
