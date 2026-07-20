import 'package:flutter/material.dart';

import '../data/ausgabestellen.dart';
import '../l10n/strings.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// Start: „Deine Ausgabestelle" (per PLZ), nächster Termin, Route,
/// Überblick über alle Ausgabestellen und die Geschäftsstelle.
class StartTab extends StatelessWidget {
  final String lang;
  final String plz;
  const StartTab({super.key, required this.lang, required this.plz});

  String _terminText(Ausgabestelle a) {
    final termin = a.naechsteAusgabe(DateTime.now());
    final tag = t(lang, 'weekday.${termin.weekday}');
    final zeit =
        '${termin.hour.toString().padLeft(2, '0')}:${termin.minute.toString().padLeft(2, '0')}';
    return '$tag, ${termin.day}.${termin.month}. · ab $zeit';
  }

  @override
  Widget build(BuildContext context) {
    final meine = ausgabestelleFuerPlz(plz);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            const TafelLogoMark(size: 40),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t(lang, 'app.title'),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                Text(t(lang, 'app.subtitle'),
                    style: const TextStyle(
                        fontSize: 11,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w700,
                        color: TafelColors.petrol)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ===== Deine Ausgabestelle =====
        if (meine != null) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: TafelColors.orange,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${t(lang, 'start.yourStation')} · PLZ $plz',
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.4)),
                const SizedBox(height: 4),
                Text(meine.name,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                Text('${meine.ort}\n${meine.adresse}',
                    style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.4)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          TafelCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionLabel(t(lang, 'start.nextIssue')),
                Row(
                  children: [
                    const Icon(Icons.event_available, color: TafelColors.green, size: 28),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(_terminText(meine),
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: TafelColors.greenLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('✓ ${t(lang, 'start.takesPlace')}',
                      style: const TextStyle(
                          color: TafelColors.green, fontWeight: FontWeight.w700, fontSize: 13)),
                ),
                const SizedBox(height: 8),
                Text(t(lang, 'start.contribution'),
                    style: const TextStyle(color: TafelColors.grey, fontSize: 13)),
                if (meine.hinweis != null) ...[
                  const SizedBox(height: 4),
                  Text(meine.hinweis!,
                      style: const TextStyle(color: TafelColors.grey, fontSize: 13)),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => openRoute(meine.adresse),
                        icon: const Icon(Icons.map_outlined),
                        label: Text(t(lang, 'start.route')),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => callPhone(geschaeftsstelle.telefon),
                        icon: const Icon(Icons.call_outlined),
                        label: Text(t(lang, 'start.call')),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ] else
          TafelCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, color: TafelColors.orange),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(t(lang, 'start.unknownPlz'),
                        style: const TextStyle(height: 1.5))),
              ],
            ),
          ),

        const SizedBox(height: 20),

        // ===== Alle Ausgabestellen =====
        SectionLabel(t(lang, 'start.allStations')),
        for (final a in ausgabestellen) ...[
          TafelCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a.name,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                      Text(a.adresse,
                          style: const TextStyle(color: TafelColors.grey, fontSize: 13)),
                      const SizedBox(height: 3),
                      Text(
                        a.zeiten
                            .map((z) => '${t(lang, 'weekday.${z.wochentag}')} ab ${z.ab}')
                            .join(' · '),
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                      ),
                      Text('PLZ ${a.plzBereiche.join(', ')}',
                          style: const TextStyle(color: TafelColors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => openRoute(a.adresse),
                  icon: const Icon(Icons.directions_outlined, color: TafelColors.orange),
                  tooltip: t(lang, 'start.route'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],

        const SizedBox(height: 12),

        // ===== Geschäftsstelle =====
        SectionLabel(t(lang, 'start.office')),
        TafelCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(geschaeftsstelle.name,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
              Text(geschaeftsstelle.adresse),
              const SizedBox(height: 4),
              Text('${t(lang, 'start.officeRegistration')}: ${geschaeftsstelle.anmeldung}',
                  style: const TextStyle(fontSize: 13)),
              Text('☎ ${geschaeftsstelle.telefonAnzeige}',
                  style: const TextStyle(fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
