import 'package:firebase_auth/firebase_auth.dart';

import '../../../feature/auth/data/model/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserModel? get currentUser {
    final user = _firebaseAuth.currentUser;
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  Stream<UserModel?> get authStateChange {
    return _firebaseAuth.authStateChanges().map(
          (user) => user != null ? UserModel.fromFirebaseUser(user) : null,
        );
  }

  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return UserModel.fromFirebaseUser(
        credential.user!); // ✅ Now it returns UserModel
  }

  Future<UserModel> createUserWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return UserModel.fromFirebaseUser(
        credential.user!); // ✅ Now it returns UserModel
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
