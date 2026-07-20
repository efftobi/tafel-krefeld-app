import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';

/// Kleine, überall genutzte Bausteine.

/// Logo-Marke: orangefarbener Kreis mit Besteck — angelehnt an die Wortmarke
/// der Tafel Krefeld. Die Original-Logodateien (Wortmarke mit Weber-Figur,
/// Kindertafel-Drachen) werden als Assets ergänzt, sobald sie als Dateien
/// vorliegen; bis dahin dient diese Vektor-Näherung als Platzhalter.
class TafelLogoMark extends StatelessWidget {
  final double size;
  const TafelLogoMark({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: TafelColors.orange,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(Icons.restaurant, color: Colors.white, size: size * 0.55),
    );
  }
}

class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.4,
          color: TafelColors.grey,
        ),
      ),
    );
  }
}

class TafelCard extends StatelessWidget {
  final Widget child;
  const TafelCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: TafelColors.line, width: 1.5),
      ),
      child: child,
    );
  }
}

Future<void> openRoute(String adresse) async {
  final query = Uri.encodeComponent(adresse);
  final uri = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$query');
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

Future<void> callPhone(String number) async {
  await launchUrl(Uri.parse('tel:$number'));
}
