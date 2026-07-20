import 'package:flutter/material.dart';

import '../data/ausgabestellen.dart';
import '../l10n/strings.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// Anmeldung: Schritt-für-Schritt + Dokumenten-Checkliste.
/// (Das Vor-Anmeldeformular kommt mit der Backend-Anbindung in v0.2.)
class AnmeldungTab extends StatelessWidget {
  final String lang;
  const AnmeldungTab({super.key, required this.lang});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(t(lang, 'anmeldung.title'),
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
        const SizedBox(height: 14),
        Row(
          children: [
            _Step(number: 1, text: t(lang, 'anmeldung.step1')),
            const SizedBox(width: 8),
            _Step(number: 2, text: t(lang, 'anmeldung.step2')),
            const SizedBox(width: 8),
            _Step(number: 3, text: t(lang, 'anmeldung.step3')),
          ],
        ),
        const SizedBox(height: 18),
        SectionLabel(t(lang, 'anmeldung.docsTitle')),
        TafelCard(
          child: Column(
            children: [
              _DocRow(emoji: '📄', text: t(lang, 'anmeldung.doc1')),
              const Divider(height: 18),
              _DocRow(emoji: '🪪', text: t(lang, 'anmeldung.doc2')),
              const Divider(height: 18),
              _DocRow(emoji: '👨‍👩‍👧', text: t(lang, 'anmeldung.doc3')),
            ],
          ),
        ),
        const SizedBox(height: 18),
        SectionLabel(t(lang, 'anmeldung.whenWhere')),
        TafelCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(geschaeftsstelle.anmeldung,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
              Text(geschaeftsstelle.adresse, style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => openRoute(geschaeftsstelle.adresse),
                icon: const Icon(Icons.map_outlined),
                label: Text(t(lang, 'start.route')),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: TafelColors.orangeLight,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(t(lang, 'anmeldung.note'), style: const TextStyle(height: 1.5)),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _Step extends StatelessWidget {
  final int number;
  final String text;
  const _Step({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: TafelColors.line, width: 1.5),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: TafelColors.orange,
              child: Text('$number',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14)),
            ),
            const SizedBox(height: 6),
            Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class _DocRow extends StatelessWidget {
  final String emoji;
  final String text;
  const _DocRow({required this.emoji, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: TafelColors.orangeLight,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(emoji, style: const TextStyle(fontSize: 20)),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 15, height: 1.4))),
      ],
    );
  }
}
