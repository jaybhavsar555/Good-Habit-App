import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:good_habit_app/screens/splash_screen.dart';
import 'package:good_habit_app/utils/constants/app_routes.dart';
import 'package:good_habit_app/utils/constants/app_styles.dart';
import 'feature/auth/data/repositories/auth_repository_impl.dart';
import 'feature/auth/presentation/bloc/auth_bloc.dart';
import 'feature/auth/presentation/pages/sign_in_page.dart';
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
  late final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 843),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Styles.bgColor),
          useMaterial3: true,
        ),
        onGenerateRoute: AppRoutes().routeGenerator,
        home: BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(AuthRepositoryImpl()),
          child: const SignInPage(),
        ),
      ),
    );
  }
}
