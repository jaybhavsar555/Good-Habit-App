import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.uid,
      super.username,
      required super.email,
      super.gender,
      super.dateOfBirth});

  // ✅ Factory method to convert Firebase User to UserModel
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
        uid: user.uid,
        username: user.displayName,
        email: user.email ?? '',
        gender: null,
        dateOfBirth: null);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"] ?? '',
      email: map["email"] ?? '',
      username: map["username"] ?? '',
      gender: map["gender"] ?? '',
      dateOfBirth: map["dateOfBirth"] ?? '',
    );
  }
}
