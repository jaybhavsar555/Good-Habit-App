import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_habit_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:good_habit_app/feature/auth/presentation/pages/sign_up_page.dart';
import 'package:good_habit_app/feature/habit/presentation/pages/habit_home_page.dart';
import 'package:good_habit_app/utils/transitions/fade_route_transition.dart';
import 'package:good_habit_app/utils/transitions/right_slide_in_route_transition.dart';

import '../../feature/auth/data/repositories/auth_repository_impl.dart';
import '../../feature/auth/presentation/pages/sign_in_page.dart';

class AppRoutes {
  //Auth Routes
  static const String signInRoute = '/Auth/SignIn';
  static const String signUpRoute = '/Auth/SignUp';

  //task
  static const String habitHomeRoute = '/Habit/HomePage';

  Route<dynamic>? routeGenerator(RouteSettings settings) {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: settings.name);

    var args;
    if (settings.arguments != null) {
      args = settings.arguments as Map<String, dynamic>;
    }

    switch (settings.name) {
      case AppRoutes.signInRoute:
        return FadeInRouteTransition(
            page: BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(AuthRepositoryImpl()),
          child: const SignInPage(),
        ));
      case AppRoutes.signUpRoute:
        return FadeInRouteTransition(page: const SignUpPage());
      case AppRoutes.habitHomeRoute:
        return RightSlideInRouteTransition(page: HabitHomePage());
    }
    return null;
  }
}
