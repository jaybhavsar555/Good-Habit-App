class UserModel {
  String? uid;
  String? username;
  String? email;
  String? password;

  // Int? age;
  String? gender;
  String? dateOfBirth;

  //named parameter constructor
  UserModel(
      {this.uid,
      this.username,
      this.email,
      this.password,
      this.dateOfBirth,
      this.gender});

  //fn to receive the data from server
  factory UserModel.fromMap(map) => UserModel(
        uid: map["uid"],
        username: map["username"],
        email: map["email"],
        password: map["password"],
        // age: map["age"],
        gender: map["gender"],
        dateOfBirth: map["dateOfBirth"],
      );

  //fn to send the data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'password': password,
      // 'age':age,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
    };
  }
}
