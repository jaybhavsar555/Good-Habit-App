import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String? username;
  final String email;
  final String? gender;
  final String? dateOfBirth;

  const UserEntity({
    required this.uid,
    this.username,
    required this.email,
    this.gender,
    this.dateOfBirth,
  });

  @override
  List<Object?> get props => [uid, email, username, gender, dateOfBirth];
}
