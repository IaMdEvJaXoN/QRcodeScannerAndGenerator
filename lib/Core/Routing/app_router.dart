import 'package:flutter/widgets.dart';
import 'package:proscan/Core/Routing/routes.dart';
import 'package:proscan/Features/CreateQR/Presentation/Screens/history.dart';
import 'package:proscan/Features/CreateQR/Presentation/Screens/qr_type_selection.dart';
import 'package:proscan/Features/HomeScreen/Presentation/Screens/home_screen.dart';
import 'package:proscan/Features/ScanQR/Presentation/Screens/history_screen.dart';
import 'package:proscan/Features/ScanQR/Presentation/Screens/scan_qr.dart';
import 'package:proscan/Shared/Screens/appshell.dart';
import 'package:proscan/Shared/Screens/splash_screen.dart';
import 'package:proscan/Shared/Screens/startup_permissions.dart';

class AppRouter {
  static Map<String, WidgetBuilder> appRoutes = {
    AppRoutes.splash: (context) => const SplashScreen(),
    AppRoutes.appShell: (context) => const Appshell(),
    AppRoutes.home: (context) => const HomeScreen(),
    AppRoutes.scanQr: (context) => const ScannerScreen(),
    AppRoutes.scanHist: (context) => const ScanHistoryScreen(),
    AppRoutes.qrTypeSelect: (context) => const QrTypeSelectionScreen(),
    AppRoutes.generatedHist: (context) => const GeneratedHistoryScreen(),
    AppRoutes.startUp: (context) => const StartupGate(),
  };
}
