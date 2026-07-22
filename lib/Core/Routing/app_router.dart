import 'package:flutter/widgets.dart';
import 'package:proscan/Core/Routing/routes.dart';
import 'package:proscan/splash_screen.dart';

class AppRouter {
  static Map<String, WidgetBuilder> appRoutes = {
    AppRoutes.splash: (context) => const SplashScreen(),
  };
}
