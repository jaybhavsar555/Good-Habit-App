import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:good_habit_app/screens/sign_up_screen.dart';

import '../utils/constants/app_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.primaryColor,
        body: Center(
          child: Column(
            children: [
              Gap(
                50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _firebaseAuth.currentUser?.displayName ??
                        'Unkown User Name',
                    style: Styles.textStyle1
                        .copyWith(color: Colors.white, fontSize: 17),
                  ),
                  Gap(
                    10.w,
                  ),
                  IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      icon: const Icon(Icons.logout)),
                ],
              ),
            ],
          ),
        ));
  }
}
