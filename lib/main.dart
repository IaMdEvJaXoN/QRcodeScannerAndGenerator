import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:proscan/Core/Routing/app_router.dart';
import 'package:proscan/Core/Routing/routes.dart';
import 'package:proscan/Core/Themes/app_themes.dart';
import 'package:proscan/Core/Utils/shared_utils/adapter_names.dart';
import 'package:proscan/Features/CreateQR/Data/Models/model.dart';
import 'package:proscan/Features/ScanQR/Data/Model/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();

  Hive.registerAdapter(ScanModelAdapter());
  Hive.registerAdapter(GeneratedModelAdapter());

  await Hive.openBox<ScanModel>(AdapterNames.scanHistoryBoxName);
  await Hive.openBox<GeneratedQrModel>(AdapterNames.generatedQrsHistoryBoxName);
  runApp(
    ProviderScope(
      //overrides: [sharedPrefsClassProvider.overrideWithValue(SharedPrefs(prefs: prefs))],
      child: ProScanApp(),
    ),
  );
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
