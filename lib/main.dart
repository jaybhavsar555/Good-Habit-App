import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:good_habit_app/screens/splash_screen.dart';
import 'package:good_habit_app/utils/app_styles.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Styles.bgColor),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
