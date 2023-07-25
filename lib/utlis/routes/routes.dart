import 'package:flutter/material.dart';
import 'package:test/utlis/routes/routes_name.dart';
import 'package:test/view/home_screen.dart';
import 'package:test/view/login_view.dart';
import 'package:test/view/signup_view.dart';
import 'package:test/view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());

      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());

      case RoutesName.safehome:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());

      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUp());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No Routes defined"),
            ),
          );
        });
    }
  }
}
