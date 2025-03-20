import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signUp(String email, String password, String username,
      String gender, String dateOfBirth);

  Future<UserEntity> signIn(String email, String password);

  Future<void> signOut();

  Stream<UserEntity?> get authStateChanges;
}
