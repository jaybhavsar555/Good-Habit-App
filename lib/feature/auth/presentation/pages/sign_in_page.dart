import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:good_habit_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:good_habit_app/feature/auth/presentation/bloc/auth_state.dart';
import 'package:good_habit_app/widget/hap_button.dart';
import 'package:good_habit_app/widget/hap_text.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants/app_routes.dart';
import '../../../../utils/constants/app_styles.dart';
import '../bloc/auth_event.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formkey = GlobalKey<FormState>();

  //editTeext controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FocusNode fnEmail = FocusNode();
  FocusNode fnPass = FocusNode();

  //firebase
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  String? value;

  bool isLoading = false, failed = false;

  @override
  Widget build(BuildContext context) {
    //text email field
    final TextFormField emailfield = TextFormField(
      autofocus: false,
      focusNode: fnEmail,
      controller: emailController,
      style: GoogleFonts.inter(
          textStyle: Theme.of(context).textTheme.headlineSmall,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: Styles.textColor),
      keyboardType: TextInputType.emailAddress,
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

      // validator: (){},
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

    //password text field
    final TextFormField passwordfield = TextFormField(
      autofocus: false,
      focusNode: fnPass,
      obscureText: true,
      style: GoogleFonts.inter(
          textStyle: Theme.of(context).textTheme.headlineSmall,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: Styles.textColor),
      controller: passwordController,
      // validator: (){},
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
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Styles.primaryColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            current is AuthSuccess || current is AuthFailure,
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.habitHomeRoute, (route) => false);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            isLoading = true;
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthFailure) {
            //failure
            isLoading = false;
            failed = true;

            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              if (fnEmail.hasFocus || fnPass.hasFocus) {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            });
          }

          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //App logo
                      SizedBox(
                        height: 120,
                        child: HapText(
                          msg: "App Logo",
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),

                      Gap(7.h),
                      emailfield,
                      Gap(17.h),
                      passwordfield,
                      Gap(30.h),
                      // loginbtn,
                      HapButton(
                        onClick: () {
                          if (_formkey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  SignInEvent(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                          }
                        },
                        msg: 'Sign In',
                      ),
                      Gap(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          HapText(
                            msg: "Don`t have account?",
                            textColor: Colors.white,
                          ),
                          const Gap(6),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.signUpRoute);
                            },
                            child: HapText(
                              msg: "SignUp",
                              textColor: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
