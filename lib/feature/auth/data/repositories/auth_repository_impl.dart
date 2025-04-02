import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_habit_app/feature/auth/data/model/user_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/service/firebase/auth_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  late final AuthService authService;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserModel> signIn(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final doc =
          await _firestore.collection("users").doc(credential.user!.uid).get();
      return UserModel.fromMap(doc.data()!);
    } catch (e) {
      throw Exception("Sign in failed: ${e.toString()}");
    }
  }

  @override
  Future<UserModel> signUp(
    String email,
    String password,
    String username,
    String gender,
    String dateOfBirth,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        UserModel userModel = UserModel(
          uid: user.uid,
          email: email,
          username: username,
          gender: gender,
          dateOfBirth: dateOfBirth,
        );
        await _firestore
            .collection("users")
            .doc(user.uid)
            .set(userModel.toMap());
        return userModel;
      } else {
        throw Exception("User sign-Up failed");
      }
    } catch (e) {
      throw Exception("Sign up failed: ${e.toString()}");
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await authService.signOut();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges => authService.authStateChange;
}
