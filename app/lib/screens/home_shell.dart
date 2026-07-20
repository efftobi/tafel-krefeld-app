import 'package:flutter/material.dart';

import '../l10n/strings.dart';
import 'anmeldung_tab.dart';
import 'hilfe_tab.dart';
import 'mehr_tab.dart';
import 'start_tab.dart';

/// Grundgerüst mit Tab-Leiste: Start · Anmeldung · Hilfe · Mehr.
/// (Der Tab „Gästekarte" kommt in Ausbaustufe 2.)
class HomeShell extends StatefulWidget {
  final String lang;
  final String plz;
  const HomeShell({super.key, required this.lang, required this.plz});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final lang = widget.lang;
    final tabs = [
      StartTab(lang: lang, plz: widget.plz),
      AnmeldungTab(lang: lang),
      HilfeTab(lang: lang),
      MehrTab(lang: lang),
    ];
    return Scaffold(
      body: SafeArea(child: tabs[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: t(lang, 'tab.start')),
          NavigationDestination(
              icon: const Icon(Icons.edit_note_outlined),
              selectedIcon: const Icon(Icons.edit_note),
              label: t(lang, 'tab.anmeldung')),
          NavigationDestination(
              icon: const Icon(Icons.volunteer_activism_outlined),
              selectedIcon: const Icon(Icons.volunteer_activism),
              label: t(lang, 'tab.hilfe')),
          NavigationDestination(
              icon: const Icon(Icons.menu),
              selectedIcon: const Icon(Icons.menu),
              label: t(lang, 'tab.mehr')),
        ],
      ),
    );
  }
}
