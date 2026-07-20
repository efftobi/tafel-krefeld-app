import 'package:flutter/material.dart';

import '../data/ausgabestellen.dart';
import '../l10n/strings.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// Hilfe in Krefeld: Kindertafel, Mittagstisch & weitere Anlaufstellen.
/// v0.1: statische Übersicht; Details/Adressen folgen mit dem Backend.
class HilfeTab extends StatelessWidget {
  final String lang;
  const HilfeTab({super.key, required this.lang});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('🎒', t(lang, 'hilfe.kindertafel'), t(lang, 'hilfe.kindertafelSub')),
      ('🍲', t(lang, 'hilfe.mittagstisch'), t(lang, 'hilfe.mittagstischSub')),
      ('👕', t(lang, 'hilfe.kleiderkammer'), t(lang, 'hilfe.kleiderkammerSub')),
      ('🏛', t(lang, 'hilfe.beratung'), t(lang, 'hilfe.beratungSub')),
      ('⚽', t(lang, 'hilfe.sport'), t(lang, 'hilfe.sportSub')),
      ('💬', t(lang, 'hilfe.sprache'), t(lang, 'hilfe.spracheSub')),
    ];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(t(lang, 'hilfe.title'),
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
        Text(t(lang, 'hilfe.subtitle'),
            style: const TextStyle(color: TafelColors.grey)),
        const SizedBox(height: 14),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.15,
          children: [
            for (final (emoji, title, sub) in items)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: TafelColors.line, width: 1.5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(emoji, style: const TextStyle(fontSize: 28)),
                    const SizedBox(height: 6),
                    Text(title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 3),
                    Text(sub,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 11, color: TafelColors.grey, height: 1.3)),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 14),
        FilledButton.icon(
          onPressed: () => callPhone(geschaeftsstelle.telefon),
          icon: const Icon(Icons.call_outlined),
          label: Text('${t(lang, 'start.call')} · ${geschaeftsstelle.telefonAnzeige}'),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
