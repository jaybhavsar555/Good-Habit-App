import 'package:firebase_auth/firebase_auth.dart';

import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class AuthStateChangeUseCase {
  final AuthRepository repository;

  AuthStateChangeUseCase(this.repository);

  Stream<UserEntity?> call() {
    return repository.authStateChanges;
  }
}
