import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  AppThemes._();

  static const Color primary = Color(0xFF00BFA5);
  static const Color background = Color(0xFFF4FBF7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primaryText = Color(0xFF000000);
  static const Color secondaryText = Color(0xFF3C4A46);
  static const Color outline = Color(0xFFBBCAC4);
  static const Color error = Color(0xFFBA1A1A);

  // Buttons 16dp, Cards 20dp, Input Fields 16dp,
  // Bottom Sheets 28dp (top corners only), FAB circular.
  static const double buttonRadius = 16;
  static const double cardRadius = 20;
  static const double inputRadius = 16;
  static const double bottomSheetRadius = 28;

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // "Color System" — maps the fixed palette onto Material 3's
      // ColorScheme roles so all Material widgets inherit it automatically.
      colorScheme: const ColorScheme.light(
        primary: primary,
        onPrimary: surface,
        secondary: primary,
        onSecondary: surface,
        surface: surface,
        onSurface: primaryText,
        error: error,
        onError: surface,
        outline: outline,
        outlineVariant: outline,
      ),
      scaffoldBackgroundColor: background,

      // TYPOGRAPHY
      // Spec: "Typography" — Inter font family, SemiBold headlines,
      // Medium page titles/labels, Regular body text, comfortable
      // line spacing, primary/secondary text colors applied per role.
      textTheme: baseTextTheme
          .copyWith(
            displayLarge: baseTextTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: primaryText,
              height: 1.2,
            ),
            headlineLarge: baseTextTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: primaryText,
              height: 1.25,
            ),
            headlineMedium: baseTextTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: primaryText,
              height: 1.25,
            ),
            titleLarge: baseTextTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: primaryText,
              height: 1.3,
            ),
            titleMedium: baseTextTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: primaryText,
              height: 1.3,
            ),
            bodyLarge: baseTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              color: primaryText,
              height: 1.4,
            ),
            bodyMedium: baseTextTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: secondaryText,
              height: 1.4,
            ),
            labelLarge: baseTextTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: primaryText,
            ),
            labelMedium: baseTextTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: secondaryText,
            ),
          )
          .apply(bodyColor: primaryText, displayColor: primaryText),

      // APP BAR
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: background,
        foregroundColor: primaryText,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: primaryText,
        ),
        iconTheme: const IconThemeData(color: primaryText, size: 24),
      ),

      // CARD
      cardTheme: CardThemeData(
        color: surface,
        elevation: 1,
        shadowColor: primaryText.withValues(alpha: 0.08),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        margin: EdgeInsets.zero,
      ),

      // FILLED BUTTON (Primary actions)
      // Spec: "Shapes" (16dp radius) + "Color System"
      // (primary color reserved for primary buttons).
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: surface,
          minimumSize: const Size.fromHeight(52),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
        ),
      ),

      // OUTLINED BUTTON (Secondary actions)
      // Spec: "Shapes" (16dp radius) + "Icons"/"Color System"
      // (outline color, avoid visible heavy borders).
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryText,
          side: const BorderSide(color: outline, width: 1),
          minimumSize: const Size.fromHeight(52),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
        ),
      ),

      // TEXT BUTTON
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius),
          ),
        ),
      ),

      // FLOATING ACTION BUTTON
      // "Shapes" (circular) + "Elevation" (highest elevation)
      // + "Color System" (primary color use case).
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: surface,
        elevation: 4,
        shape: CircleBorder(),
      ),

      // INPUT FIELDS (TextField)
      // "Shapes" (16dp radius) + "Color System"
      // (outline color for borders, primary for focus state).
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: secondaryText,
        ),
        labelStyle: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: secondaryText,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: const BorderSide(color: outline, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: const BorderSide(color: outline, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputRadius),
          borderSide: const BorderSide(color: error, width: 1),
        ),
      ),

      // SEARCH BAR
      // Spec: "Material Design" widget list + "Shapes" (16dp radius)
      // + "Elevation" (subtle, tonal surface).
      searchBarTheme: SearchBarThemeData(
        backgroundColor: const WidgetStatePropertyAll(surface),
        elevation: const WidgetStatePropertyAll(0.5),
        shadowColor: WidgetStatePropertyAll(
          primaryText.withValues(alpha: 0.05),
        ),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(inputRadius),
            side: const BorderSide(color: outline, width: 1),
          ),
        ),
        hintStyle: WidgetStatePropertyAll(
          GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: secondaryText,
          ),
        ),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: primaryText,
          ),
        ),
      ),

      // NAVIGATION BAR (bottom navigation)
      // Spec: "Material Design" widget list + "Color System"
      // (primary for selected state) + "Elevation" (subtle).
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        elevation: 1,
        surfaceTintColor: Colors.transparent,
        indicatorColor: primary.withValues(alpha: 0.12),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: selected ? primary : secondaryText,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? primary : secondaryText,
            size: 24,
          );
        }),
      ),

      // DIVIDER
      // Spec: "Color System" (outline) — used to separate list items
      // and sections without heavy visual weight.
      dividerTheme: const DividerThemeData(
        color: outline,
        thickness: 0.6,
        space: 1,
      ),

      // ICON BUTTON
      // Spec: "Icons" — Rounded Material Symbols, standard sizing
      // (24 / 28 / 32dp depending on hierarchy).
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: primaryText, iconSize: 24),
      ),
      iconTheme: const IconThemeData(color: primaryText, size: 24),

      // SWITCH
      // Spec: "Settings" screen usage + "Color System"
      // (primary for the active/on state).
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primary;
          return outline.withValues(alpha: 0.4);
        }),
        thumbColor: const WidgetStatePropertyAll(surface),
      ),

      // SLIDER
      // Spec: "Scanner Screen" zoom slider usage + "Color System"
      // (primary for active track/thumb).
      sliderTheme: SliderThemeData(
        activeTrackColor: primary,
        inactiveTrackColor: outline.withValues(alpha: 0.4),
        thumbColor: primary,
        overlayColor: primary.withValues(alpha: 0.12),
      ),

      // BOTTOM SHEET
      // Spec: "Shapes" — 28dp top corners only.
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(bottomSheetRadius),
          ),
        ),
      ),

      // DIALOG
      // Spec: "Elevation" — dialogs use medium elevation.
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
      ),
    );
  }
}
