import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proscan/Core/Routing/app_router.dart';
import 'package:proscan/Core/Routing/routes.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(ProviderScope(child: ProScanApp()));
}

class ProScanApp extends StatelessWidget {
  const ProScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ProScan",
      initialRoute: AppRoutes.splash,
      routes: AppRouter.appRoutes,
      theme: AppThemes.lightTheme,
      themeMode: ThemeMode.light,
    );
  }
}
