import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proscan/Core/Themes/app_themes.dart';
import 'package:proscan/Features/CreateQR/Presentation/Screens/qr_type_selection.dart';
import 'package:proscan/Features/HomeScreen/Presentation/Screens/home_screen.dart';
import 'package:proscan/Features/ScanQR/Presentation/Screens/scan_qr.dart';
import 'package:proscan/Features/Settings/Presentation/Providers/beep_notifier.dart';
import 'package:proscan/Features/Settings/Presentation/Screens/settings_screen.dart';
import 'package:proscan/Shared/Providers/BottomNav_selectedIndexProvider/selected_index_provider.dart';
import 'package:proscan/Shared/Screens/shared_history_screen.dart';
import 'package:proscan/Shared/Widgets/bottom_navigationbar.dart';

//This is the shell of the app,It has the scaffold and Indexed Stack inside it.
//BottomNav bar lives here
class Appshell extends ConsumerStatefulWidget {
  const Appshell({super.key});

  @override
  ConsumerState<Appshell> createState() => _AppshellState();
}

class _AppshellState extends ConsumerState<Appshell> {
  static const List<Widget> _screens = [
    HomeScreen(),
    ScannerScreen(),
    QrTypeSelectionScreen(),
    SharedHistoryScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    ref.read(beepProvider);
  
    return Scaffold(
      backgroundColor: AppThemes.background,
      body: IndexedStack(index: selectedIndex, children: _screens),
      bottomNavigationBar: AppBottomNavigationBar(selectedIndex: selectedIndex),
    );
  }
}
