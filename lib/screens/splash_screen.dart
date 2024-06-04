import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_habit_app/screens/sign_up_screen.dart';

import '../utils/app_styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.bgColor,
        body: AnimatedSplashScreen(
          splash: Icons.app_blocking,
          duration: 1500,
          nextScreen: SignUpScreen(),
          backgroundColor: Styles.bgColor,
          splashTransition: SplashTransition.scaleTransition,
        ));
  }
}
