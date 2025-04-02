import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants/app_styles.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //global key that uniquely identifies the form widget and allows to validate the form
  final _formkey = GlobalKey<FormState>();

  //TextFormFieldController
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cnfpasswordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  var gender;

  @override
  Widget build(BuildContext context) {
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
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
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

    return Scaffold(
      backgroundColor: Styles.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100.h,
                    child: const Text(
                      "App Logo",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Gap(7.h),
                  usernameField,
                  Gap(10.h),
                  emailfield,
                  Gap(10.h),
                  passwordfield,
                  Gap(10.h),
                  cnfpasswordfield,
                  Gap(10.h),
                  Row(
                    children: [
                      //DOB form field
                      SizedBox(width: 170.0.w, child: dateofbirthformfield),
                      Gap(12.h),
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
                                prefixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(22, 15, 20, 15),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black))),
                            elevation: 2,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                            isDense: true,
                            iconSize: 30.0,
                            iconEnabledColor: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(50.h),
                ],
              ),
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
}
