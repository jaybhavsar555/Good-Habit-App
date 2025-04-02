import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:good_habit_app/screens/sign_up_screen.dart';
import 'package:good_habit_app/utils/constants/app_styles.dart';
import 'package:intl/intl.dart';

import '../model/user_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //global key that uniquely identifies the form widget and allows to validate the form
  final _formkey = GlobalKey<FormState>();

  //Firebase auth obj
  final _auth = FirebaseAuth.instance;

  //TextFormFieldController
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cnfpasswordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  var gender;

  get regex => null;

  // late final List<String> gender=["Male","Female","other"];

  @override
  Widget build(BuildContext context) {
    //username Form Fields
    final TextFormField usernameField = TextFormField(
      autofocus: false,
      controller: usernameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regExp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("FirstName cannot be empty!");
        }
        // if (!regex.hasMatch(value)) {
        //   return ("Enter Valid FirstName(Min. 3 Character)");
        // }
        return null;
      },
      onSaved: (value) {
        usernameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Username",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //email field
    final TextFormField emailfield = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //password field
    final TextFormField passwordfield = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //cnf password field
    final TextFormField cnfpasswordfield = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: cnfpasswordController,
      validator: (value) {
        if (cnfpasswordController.text != passwordController.text) {
          return "Password dont match";
        }
        return null;
      },
      onSaved: (value) {
        cnfpasswordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final TextFormField dateofbirthformfield = TextFormField(
      controller: dateOfBirthController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.calendar_month),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "DOB",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Select Date of Birth");
        }
        return null;
      },
      onTap: () => onTapFunction(context: context),
    );

//registration btn
    final signup = Container(
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xD91130CE),
        child: MaterialButton(
          padding: const EdgeInsets.all(10),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(emailController.text, passwordController.text);
          },
          child: Text(
            "SignUp",
            style:
                Styles.textStyle1.copyWith(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Styles.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              //contains App logo and Form
              child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //App logo
                      const SizedBox(
                        height: 120,
                        child: Text(
                          "App Logo",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),

                      const Gap(7),
                      usernameField,
                      const Gap(10),
                      emailfield,
                      const Gap(10),
                      passwordfield,
                      const Gap(10),
                      cnfpasswordfield,
                      const Gap(10),
                      Row(
                        children: [
                          //DOB form field
                          SizedBox(width: 170.0, child: dateofbirthformfield),
                          const Gap(12),
                          //gender selection
                          SizedBox(
                            width: 170,
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(canvasColor: Colors.black),
                              child: DropdownButtonFormField(
                                autofocus: false,
                                isExpanded: true,
                                hint: Text("Gender"),
                                items: const [
                                  DropdownMenuItem<String>(
                                    child: Text("Male"),
                                    value: "Male",
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "Female",
                                    child: Text('Female'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "Other",
                                    child: Text('Other'),
                                  ),
                                ],
                                onChanged: (value) async {
                                  setState(() {
                                    genderController.text = value.toString();
                                  });
                                },
                                onSaved: (value) {
                                  genderController.text = value.toString();
                                },
                                value: gender,
                                validator: (value) => value == null
                                    ? 'Please fill in your gender'
                                    : null,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(22, 15, 20, 15),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                elevation: 2,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                isDense: true,
                                iconSize: 30.0,
                                iconEnabledColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(50),
                      signup,
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  //fn to pick date
  onTapFunction({required BuildContext context}) async {
    DateTime? pickeDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (pickeDate == null) return;
    dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(pickeDate);
  }

  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  void postDetailToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.username = usernameController.text;
    userModel.password = passwordController.text;
    userModel.gender = genderController.text;
    userModel.dateOfBirth = dateOfBirthController.text;

    //convert the password to the hashable using sha256//

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account Created Successfully!!");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
        (route) => false);
  }
}
