import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_shell.dart';
import 'screens/onboarding_screen.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(TafelApp(prefs: prefs));
}

/// App-weiter Zustand (v0.1 bewusst simpel, ohne State-Management-Paket):
/// Sprache + PLZ, lokal in SharedPreferences gespeichert.
class TafelApp extends StatefulWidget {
  final SharedPreferences prefs;
  const TafelApp({super.key, required this.prefs});

  static TafelAppState of(BuildContext context) =>
      context.findAncestorStateOfType<TafelAppState>()!;

  @override
  State<TafelApp> createState() => TafelAppState();
}

class TafelAppState extends State<TafelApp> {
  String? lang;
  String? plz;

  @override
  void initState() {
    super.initState();
    lang = widget.prefs.getString('lang');
    plz = widget.prefs.getString('plz');
  }

  Future<void> setup(String newLang, String newPlz) async {
    await widget.prefs.setString('lang', newLang);
    await widget.prefs.setString('plz', newPlz);
    setState(() {
      lang = newLang;
      plz = newPlz;
    });
  }

  Future<void> reset() async {
    await widget.prefs.remove('lang');
    await widget.prefs.remove('plz');
    setState(() {
      lang = null;
      plz = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ready = lang != null && plz != null;
    return MaterialApp(
      title: 'Meine Tafel Krefeld',
      debugShowCheckedModeBanner: false,
      theme: buildTafelTheme(),
      home: ready
          ? HomeShell(lang: lang!, plz: plz!)
          : OnboardingScreen(onDone: setup),
    );
  }
}
