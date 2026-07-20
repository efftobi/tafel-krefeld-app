import 'package:flutter/material.dart';

/// Design-Bausteine — offizielle CI der Tafel Krefeld (Freigabe liegt vor):
/// Tafel-Orange, Sand und Petrol aus den Logo-Dateien, warmes Weiß als
/// Grundfläche. Details siehe docs/brand.md.
class TafelColors {
  // Offizielle CI-Farben der Tafel Krefeld (aus den bereitgestellten Logos):
  static const orange = Color(0xFFEF7D00);      // Tafel-Orange (Wortmarke, Uhr-Icon)
  static const orangeDark = Color(0xFFC96900);
  static const orangeLight = Color(0xFFFDEEDC);
  static const sand = Color(0xFFC6B59A);        // Sand/Beige (KREFELD, Weber-Figur)
  static const petrol = Color(0xFF4E828C);      // Petrol (Besteck-Icon, Euro-Icon)
  static const petrolDark = Color(0xFF1D4A52);  // Dunkelpetrol (Skyline, Baum)
  static const petrolLight = Color(0xFFE3EDEF);
  // Funktionsfarben (nicht CI, nur Status):
  static const green = Color(0xFF7BA428);
  static const greenLight = Color(0xFFEEF5DC);
  static const red = Color(0xFFD23C2E);
  static const redLight = Color(0xFFFBE7E5);
  // Neutrale Töne:
  static const ink = Color(0xFF232323);
  static const grey = Color(0xFF5C5C5C);
  static const line = Color(0xFFE3DDD4);
  static const paper = Color(0xFFFAF7F2);
}

ThemeData buildTafelTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: TafelColors.orange,
      primary: TafelColors.orange,
      surface: TafelColors.paper,
    ),
    scaffoldBackgroundColor: TafelColors.paper,
  );
  return base.copyWith(
    // Große, gut lesbare Schrift ist ein zentrales Designprinzip.
    textTheme: base.textTheme.apply(
      bodyColor: TafelColors.ink,
      displayColor: TafelColors.ink,
      fontSizeFactor: 1.08,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: TafelColors.ink,
      elevation: 0,
      centerTitle: false,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: TafelColors.orange,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(52), // große Touch-Flächen
        textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: TafelColors.ink,
        minimumSize: const Size.fromHeight(52),
        side: const BorderSide(color: TafelColors.ink, width: 2),
        textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: TafelColors.orangeLight,
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: TafelColors.ink),
      ),
    ),
  );
}
