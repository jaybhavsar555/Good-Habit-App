import 'package:good_habit_app/feature/auth/domain/entities/user_entity.dart';

import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<UserEntity> execute(String email, String password) {
    return repository.signIn(email, password);
  }
}
