import 'package:flutter/material.dart';

import '../data/ausgabestellen.dart';
import '../l10n/strings.dart';
import '../main.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// Mehr: Sprache/PLZ ändern, Kontakt, Über die App.
class MehrTab extends StatelessWidget {
  final String lang;
  const MehrTab({super.key, required this.lang});

  @override
  Widget build(BuildContext context) {
    final currentLang =
        appLanguages.firstWhere((l) => l.code == lang, orElse: () => appLanguages.first);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(t(lang, 'mehr.title'),
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
        const SizedBox(height: 14),
        TafelCard(
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.language, color: TafelColors.orange),
                title: Text(t(lang, 'mehr.language')),
                subtitle: Text(currentLang.nativeName),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => TafelApp.of(context).reset(),
              ),
              const Divider(height: 1),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.location_on_outlined, color: TafelColors.orange),
                title: Text(t(lang, 'mehr.plz')),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => TafelApp.of(context).reset(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SectionLabel(t(lang, 'mehr.contact')),
        TafelCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(geschaeftsstelle.name, style: const TextStyle(fontWeight: FontWeight.w800)),
              Text(geschaeftsstelle.adresse),
              Text('☎ ${geschaeftsstelle.telefonAnzeige}'),
              Text('✉ ${geschaeftsstelle.email}'),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () => callPhone(geschaeftsstelle.telefon),
                icon: const Icon(Icons.call_outlined),
                label: Text(t(lang, 'start.call')),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SectionLabel(t(lang, 'mehr.about')),
        TafelCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t(lang, 'mehr.aboutText'), style: const TextStyle(height: 1.5)),
              const SizedBox(height: 8),
              Text(t(lang, 'mehr.dataNote'),
                  style: const TextStyle(
                      height: 1.5, color: TafelColors.grey, fontSize: 13)),
              const SizedBox(height: 8),
              const Text('Version 0.1.0',
                  style: TextStyle(color: TafelColors.grey, fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
