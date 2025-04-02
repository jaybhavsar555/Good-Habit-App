import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';

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
        return FadeInR
    }
  }
}
